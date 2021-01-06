var idMapping = {
  '': '/asciidoc/latest/syntax-quick-reference/'
}
var hash = window.location.hash
window.location.href = 'https://docs.asciidoctor.org' + ((hash && idMapping[hash.slice(1)]) || (idMapping[''] + hash))
