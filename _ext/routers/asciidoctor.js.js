var idMapping = {
  '': '/asciidoctor.js/latest/',
  'quickstart': '/asciidoctor.js/latest/setup/install/',
  'learning': '/asciidoctor.js/latest/setup/quick-tour/',
  'contributing': 'https://github.com/asciidoctor/asciidoctor.js/blob/HEAD/CONTRIBUTING.adoc',
  'copyright': 'https://github.com/asciidoctor/asciidoctor.js/blob/HEAD/LICENSE'
}

var hash = window.location.hash
var redirect = ((hash && idMapping[hash.slice(1)]) || (idMapping[''] + hash))
if (redirect.substring(0, 8) === 'https://') {
  href = redirect
} else { 
  href = 'https://docs.asciidoctor.org' + redirect
}
window.location.href = href
