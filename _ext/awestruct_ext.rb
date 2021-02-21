require 'asciidoctor'
require 'asciidoctor/extensions'
require 'awestruct/handlers/template/asciidoc'

# Monkeypatch the AsciidoctorTemplate class from Awestruct to register Asciidoctor::Document object in page context.
# Remove this hack when issue [1] will be resolved and available in a release.
# [1] https://github.com/awestruct/awestruct/issues/288
class Awestruct::Tilt::AsciidoctorTemplate
  def evaluate(scope, locals)
    @output ||= (scope.document = ::Asciidoctor.load(data, options)).convert
  end
end

#require 'open-uri/cached'
#OpenURI::Cache.cache_path = ::File.join Awestruct::Engine.instance.config.dir, 'vendor', 'uri-cache'

Asciidoctor::Extensions.register do
  current_doc = @document

  # workaround lack of docfile support for Asciidoctor base_dir option in Awestruct
  if (docfile = current_doc.attributes['docfile'])
    current_doc.instance_variable_set :@base_dir, (File.dirname docfile)
  end

  if ::Awestruct::Engine.instance.production?
    if (write_css = current_doc.attr? 'docname', 'user-manual') || (current_doc.attr? 'docname', 'migration')
      if write_css
        cssdir = current_doc.attr 'site-css_dir'
        FileUtils.mkdir_p cssdir
        Asciidoctor::Stylesheets.instance.write_primary_stylesheet cssdir
        Asciidoctor::Stylesheets.instance.write_coderay_stylesheet cssdir
      end
      current_doc.set_attr 'linkcss'
      current_doc.set_attr 'stylesdir', '/stylesheets'
    end

    docinfo_processor do
      at_location :footer
      process do |doc|
        next if (doc.attr? 'page-layout') || !(doc.attr? 'site-google_analytics_account')
        account_id = doc.attr 'site-google_analytics_account'
        %(<script>
!function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m);}(window,document,'script','//www.google-analytics.com/analytics.js','ga'),ga('create','#{account_id}','auto'),ga('send','pageview');
</script>)
      end
    end

    postprocessor do
      process do |doc, output|
        next output if doc.attr? 'page-layout'
        output
          .sub('</title>', %(</title>
<script>!function(l,p){if(l.protocol!==p){l.protocol=p}else if(l.host=="asciidoctor.netlify.com"){l.host="asciidoctor.org"}}(location,"https:")</script>))
      end
    end
  end

  postprocessor do
    process do |doc, output|
      routersdir = File.join __dir__, 'routers'
      docname = doc.attr 'docname'
      next output unless (Dir.children routersdir).include? %(#{docname}.js)
      ::Awestruct::Engine.instance.site.pages.find {|it| it.simple_name == docname }.layout = nil
      <<~EOS
      <!DOCTYPE html>
      <meta charset="utf-8">
      <meta name="robots" content="noindex">
      <script>
      #{(File.read File.join routersdir, %(#{docname}.js)).chomp}
      </script>
      <title>Redirect Notice</title>
      <h1>Redirect Notice</h1>
      <p>You are being redirected to the applicable page at <a href="https://docs.asciidoctor.org">https://docs.asciidoctor.org</a>.</p>
      EOS
    end
  end
end

module Awestruct
  class Engine
    def production?
      site.profile == 'production'
    end

    def development?
      site.profile == 'development'
    end

    def generate_on_access?
      site.config.options.generate_on_access
    end
  end
end
