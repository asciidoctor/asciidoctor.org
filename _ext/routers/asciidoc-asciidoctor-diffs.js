var idMapping = {
  '': '/asciidoctor/latest/migrate/asciidoc-py/',
  'syntax': '/asciidoctor/latest/migrate/asciidoc-py/#updated-and-deprecated-asciidoc-syntax',
  'table-of-contents-toc': '/asciidoctor/latest/migrate/asciidoc-py/#table-of-contents',
  'sections': '/asciidoctor/latest/migrate/asciidoc-py/#document-and-section-titles',
  'html-backend-and-output': '/asciidoctor/latest/migrate/asciidoc-py/#default-html-backend',
  'stylesheets': '/asciidoctor/latest/migrate/asciidoc-py/#themes',
  'processor': '/asciidoctor/latest/migrate/asciidoc-py/#processor-call'
}
var hash = window.location.hash
window.location.href = 'https://docs.asciidoctor.org' + ((hash && idMapping[hash.slice(1)]) || (idMapping[''] + hash))
