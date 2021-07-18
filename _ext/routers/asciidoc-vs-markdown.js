var idMapping = {
  '': '/asciidoc/latest/asciidoc-vs-markdown/',
  'getting-your-start-with-markdown': '/asciidoc/latest/asciidoc-vs-markdown/#starting-with-markdown'
}
var hash = window.location.hash
var url = idMapping[hash.substr(1)] || idMapping[''].concat(hash)
window.location.href = (url.substr(0, 8) === 'https://' ? '' : 'https://docs.asciidoctor.org').concat(url)
