var idMapping = {
  '': '/asciidoc/latest/asciidoc-vs-markdown/',
  'getting-your-start-with-markdown': '/asciidoc/latest/asciidoc-vs-markdown/#starting-with-markdown'
}
var url = idMapping[(window.location.hash || '').substr(1)] || idMapping['']
window.location.href = (url.substr(0, 8) === 'https://' ? '' : 'https://docs.asciidoctor.org') + url
