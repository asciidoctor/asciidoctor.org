var idMapping = {
  '': '/asciidoc/latest/syntax-quick-reference/'
}
var url = idMapping[(window.location.hash || '').substr(1)] || idMapping['']
window.location.href = (url.substr(0, 8) === 'https://' ? '' : 'https://docs.asciidoctor.org') + url
