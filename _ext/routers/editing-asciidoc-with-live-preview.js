var idMapping = {
  '': '/asciidoctor/latest/tooling/'
}
var hash = window.location.hash
window.location.href = 'https://docs.asciidoctor.org' + ((hash && idMapping[hash.slice(1)]) || idMapping[''])
