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
  current_document = @document

  # workaround lack of docfile support for Asciidoctor base_dir option in Awestruct
  if (docfile = current_document.attributes['docfile'])
    current_document.instance_variable_set :@base_dir, (File.dirname docfile)
  end

  # workaround lack of support for nested remote includes in Asciidoctor (will be fixed in 1.5.7)
  include_processor do
    handles? do |target|
      current_document.reader.cursor.dir.start_with? 'https://'
    end

    process do |doc, reader, target, attrs|
      inc_path = %(#{reader.cursor.dir}/#{target})
      begin
        inc_contents = open(inc_path, 'r') {|f| f.read }
        reader.push_include inc_contents, inc_path, target, 1, attrs
      rescue
        line_info = %(#{current_path = reader.path}: line #{reader.lineno - 1})
        warn %(asciidoctor: ERROR: #{line_info}: include uri not readable: #{inc_path})
        reader.restore_line %(Unresolved directive in #{current_path} - include::#{target}[])
      end
    end
  end unless current_document.options[:parse_header_only] || (Gem::Version.new Asciidoctor::VERSION) >= (Gem::Version.new '1.5.7')

  preprocessor do
    process do |doc, reader|
      # make the prewrap attribute overridable
      (doc.instance_variable_get :@attribute_overrides).delete 'prewrap'
      if (outfilesuffix = doc.options[:attributes]['outfilesuffix']) && (outfilesuffix.end_with? '@')
        # soft set the outfilesuffix (since soft setting from API has no effect)
        doc.set_attr 'outfilesuffix', (outfilesuffix.chop)
      end
      reader
    end
  end unless current_document.options[:parse_header_only]

  # TODO rewrite this as a docinfo processor
  postprocessor do
    process do |doc, output|
      next output if (doc.attr? 'page-layout') || !(doc.attr? 'site-google_analytics_account')
      account_id = doc.attr 'site-google_analytics_account'
      output
        .sub('</title>', %(</title>
<script>!function(l,p){if(l.protocol!==p&&l.host=="asciidoctor.org")l.protocol=p}(location,"https:")</script>))
        .rstrip.chomp('</html>').rstrip.chomp('</body>').chomp
        .concat(%(
<script>
!function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m);}(window,document,'script','//www.google-analytics.com/analytics.js','ga'),ga('create','#{account_id}','auto'),ga('send','pageview');
</script>
</body>
</html>))
    end
  end unless ::Awestruct::Engine.instance.development?
end

module Awestruct
  class Engine
    def development?
      site.profile == 'development'
    end

    def generate_on_access?
      site.config.options.generate_on_access
    end
  end
end
