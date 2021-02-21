var idMapping = {
  '': '/asciidoctor/latest/migrate/ms-word/'
}
var hash = window.location.hash
window.location.href = 'https://docs.asciidoctor.org' + ((hash && idMapping[hash.slice(1)]) || (idMapping[''] + hash))
