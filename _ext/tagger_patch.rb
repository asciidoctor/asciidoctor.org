module Awestruct::Extensions
  # This patch is necessary when both the posts and the index of posts are
  # nested in a subdirectory (e.g., /news). It fixes the problem of the
  # subdirectory getting appended to the end of tag URLs (e.g., /news/tag/tagname/news/)
  class TaggerPatch
    def initialize(prop_name = :posts)
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
