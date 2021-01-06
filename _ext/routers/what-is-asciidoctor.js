var idMapping = {
  '': '/asciidoctor/latest/',
  'whats-unique-about-the-asciidoctor-implementation': '/asciidoctor/latest/features/',
  'system-requirements': '/asciidoctor/latest/install/supported-platforms/'
}
var hash = window.location.hash
window.location.href = 'https://docs.asciidoctor.org' + ((hash && idMapping[hash.slice(1)]) || idMapping[''])
