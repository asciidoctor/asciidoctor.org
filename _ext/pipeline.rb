require 'erubis'
require 'zurb-foundation'

Awestruct::Extensions::Pipeline.new do
  extension Awestruct::Extensions::Posts.new('/news', :posts, nil, nil, :default_layout => 'post')
  extension Awestruct::Extensions::Paginator.new(:posts, '/news', :per_page => 5)
  extension Awestruct::Extensions::Tagger.new(:posts, '/news', '/news/tags', :per_page => 5)
  #extension Awestruct::Extensions::TagCloud.new( :posts, '/news/tags/index.html')
  # Indexifier *must* come before Atomizer
  extension Awestruct::Extensions::Indexifier.new
  extension Awestruct::Extensions::Atomizer.new(:posts, '/feed.atom', :template => '_layouts/feed.atom.haml')
  extension Awestruct::Extensions::Disqus.new

  #transformer Awestruct::Extensions::Minify.new([:js])

  helper Awestruct::Extensions::Partial
  helper Awestruct::Extensions::GoogleAnalytics
end
