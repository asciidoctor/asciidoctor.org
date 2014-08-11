require 'asciidoctor'
require 'asciidoctor/extensions'

Asciidoctor::Extensions.register do
  # workaround for Awestruct 0.5.5
  # (change lib/awestruct/handlers/asciidoctor_handler.rb, line 108 to opts[:base_dir] = @site.config.dir unless opts.key? :base_dir)
  if (docfile = @document.attributes['docfile'])
    @document.instance_variable_set :@base_dir, File.dirname(docfile)
  end

  unless ::Awestruct::Engine.instance.development?
    postprocessor {
      process {|doc, output|
        next output if (doc.attr? 'page-layout') || !(doc.attr? 'site-google_analytics_account')
        account_id = doc.attr 'site-google_analytics_account'
        %(#{output.rstrip.chomp('</html>').rstrip.chomp('</body>').chomp}
<script>
var _gaq = _gaq || [];
_gaq.push(['_setAccount','#{account_id}']);
_gaq.push(['_trackPageview']);
(function() {
  var ga = document.createElement('script');
  ga.type = 'text/javascript';
  ga.async = true;
  ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
  var s = document.getElementsByTagName('script')[0];
  s.parentNode.insertBefore(ga, s);
})();
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
