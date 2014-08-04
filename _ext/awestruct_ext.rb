require 'asciidoctor'
require 'asciidoctor/extensions'

Asciidoctor::Extensions.register do
  # workaround for Awestruct 0.5.5
  # (change lib/awestruct/handlers/asciidoctor_handler.rb, line 108 to opts[:base_dir] = @site.config.dir unless opts.key? :base_dir)
  if (docfile = @document.attributes['docfile'])
    @document.instance_variable_set :@base_dir, File.dirname(docfile)
  end
end

module Awestruct
  class Engine
    def development?
      site.profile == 'development'
    end
  end
end
