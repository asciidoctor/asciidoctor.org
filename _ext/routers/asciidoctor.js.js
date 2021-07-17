var idMapping = {
  '': '/asciidoctor.js/latest/',
  'quickstart': '/asciidoctor.js/latest/setup/install/',
  'learning': '/asciidoctor.js/latest/setup/quick-tour/',
  'contributing': 'https://github.com/asciidoctor/asciidoctor.js/blob/HEAD/CONTRIBUTING.adoc',
  'copyright': 'https://github.com/asciidoctor/asciidoctor.js/blob/HEAD/LICENSE'
}

var url = idMapping[(window.location.hash || '').substr(1)]
window.location.href = (url.substr(0, 8) === 'https://' ? '' : 'https://docs.asciidoctor.org') + url
