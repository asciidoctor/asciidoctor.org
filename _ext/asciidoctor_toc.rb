require 'asciidoctor'

module Awestruct::Extensions
  class AsciidoctorTOC
    def execute(site)
      site.pages.each do |page|
        if page.source_path.end_with? '.adoc'
          document = Asciidoctor.load_file page.source_path, header_footer: true, safe: :safe, attributes: 'idprefix idseparator=-'
          page.toc = true
          page.toc_items = []
          document.sections.each do |section|
            page.toc_items.push({title: section.captioned_title, id: section.id })
          end
        end
      end
    end
  end
end
