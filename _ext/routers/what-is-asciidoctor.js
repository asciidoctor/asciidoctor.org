var idMapping = {
  '': '/asciidoctor/latest/',
  'whats-unique-about-the-asciidoctor-implementation': '/asciidoctor/latest/features/',
  'system-requirements': '/asciidoctor/latest/install/supported-platforms/'
}
var hash = window.location.hash
var url = idMapping[hash.substr(1)] || idMapping[''].concat(hash)
window.location.href = (url.substr(0, 8) === 'https://' ? '' : 'https://docs.asciidoctor.org').concat(url)
