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
  # workaround for Awestruct 0.5.5
  # (change lib/awestruct/handlers/asciidoctor_handler.rb, line 108 to opts[:base_dir] = @site.config.dir unless opts.key? :base_dir)
  if (docfile = @document.attributes['docfile'])
    @document.instance_variable_set :@base_dir, File.dirname(docfile)
  end

  preprocessor do
    process do |doc, reader|
      # make the prewrap attribute overridable
      (doc.instance_variable_get :@attribute_overrides).delete 'prewrap'
      reader
    end
  end unless @document.options[:parse_header_only]

  unless ::Awestruct::Engine.instance.development?
    postprocessor {
      process {|doc, output|
        next output if (doc.attr? 'page-layout') || !(doc.attr? 'site-google_analytics_account')
        account_id = doc.attr 'site-google_analytics_account'
        %(#{output.rstrip.chomp('</html>').rstrip.chomp('</body>').chomp}
<script>
!function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m);}(window,document,'script','//www.google-analytics.com/analytics.js','ga'),ga('create','#{account_id}','auto'),ga('send','pageview');
</script>
</body>
</html>)
    }
  }
  end
end

module Awestruct
  class Engine
    def development?
      site.profile == 'development'
    end
  end
end
