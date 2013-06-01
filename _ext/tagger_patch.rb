module Awestruct::Extensions
  class TaggerPatch
    def initialize(prop_name)
      @prop_name = prop_name
    end

    def execute(site)
      tags = site.send("#{@prop_name}_tags")
      tags.each do |tag|
        original_output_path = tag.primary_page.output_path
        tag.primary_page.output_path = File.join(File.dirname(original_output_path), 'index.html')
      end
    end
  end
end
