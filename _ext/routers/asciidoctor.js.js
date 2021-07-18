var idMapping = {
  '': '/asciidoctor.js/latest/',
  'quickstart': '/asciidoctor.js/latest/setup/install/',
  'learning': '/asciidoctor.js/latest/setup/quick-tour/',
  'contributing': 'https://github.com/asciidoctor/asciidoctor.js/blob/HEAD/CONTRIBUTING.adoc',
  'copyright': 'https://github.com/asciidoctor/asciidoctor.js/blob/HEAD/LICENSE'
}
var hash = window.location.hash
var url = idMapping[hash.substr(1)] || idMapping[''].concat(hash)
window.location.href = (url.substr(0, 8) === 'https://' ? '' : 'https://docs.asciidoctor.org').concat(url)
