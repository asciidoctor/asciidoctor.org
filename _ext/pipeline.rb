require 'compass'
require 'zurb-foundation'
require 'awestruct_ext'
require 'tagger_patch'
require 'sass_functions'
require 'asciidoctor_toc'
require 'slim'

Awestruct::Extensions::Pipeline.new do
  engine = Engine.instance

  helper Awestruct::Extensions::Partial
  helper Awestruct::Extensions::GoogleAnalytics

  extension Awestruct::Extensions::Posts.new '/news'
  extension Awestruct::Extensions::Paginator.new :posts, '/news', :page_name => '/news/', :per_page => (engine.development? ? 50 : 5)
  unless engine.development?
    extension Awestruct::Extensions::Tagger.new :posts, '/news', '/news/tag', :page_name => '/', :per_page => 10
    extension Awestruct::Extensions::TaggerPatch.new
  end
  #extension Awestruct::Extensions::TagCloud.new :posts, '/news/tags/index.html'
  # Indexifier *must* come before Atomizer
  extension Awestruct::Extensions::Indexifier.new
  unless engine.development?
    extension Awestruct::Extensions::Atomizer.new :posts, '/feed.atom', :template => '_layouts/feed.atom.haml'
    extension Awestruct::Extensions::Disqus.new
  end

  #transformer Awestruct::Extensions::Minify.new([:js])
  extension Awestruct::Extensions::AsciidoctorTOC.new
end
