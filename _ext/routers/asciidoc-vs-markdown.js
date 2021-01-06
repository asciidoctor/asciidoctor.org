var idMapping = {
  '': '/asciidoc/latest/asciidoc-vs-markdown/',
  'getting-your-start-with-markdown': '/asciidoc/latest/asciidoc-vs-markdown/#starting-with-markdown'
}
var hash = window.location.hash
window.location.href = 'https://docs.asciidoctor.org' + ((hash && idMapping[hash.slice(1)]) || (idMapping[''] + hash))
