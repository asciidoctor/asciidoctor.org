var idMapping = {
  '': '/asciidoctor/latest/',
  'whats-unique-about-the-asciidoctor-implementation': '/asciidoctor/latest/features/',
  'system-requirements': '/asciidoctor/latest/install/supported-platforms/'
}
var url = idMapping[(window.location.hash || '').substr(1)] || idMapping['']
window.location.href = (url.substr(0, 8) === 'https://' ? '' : 'https://docs.asciidoctor.org') + url
