var idMapping = {
  '': '/asciidoctor/latest/get-started/',
  'styling-the-html-with-css': '/asciidoctor/latest/html-backend/stylesheet-modes/',
  'managing-images': '/asciidoctor/latest/html-backend/manage-images/',
  'coderay-and-pygments-stylesheets': '/asciidoctor/latest/html-backend/source-highlighting-stylesheets/',
  'converting-a-document-to-docbook': '/asciidoctor/latest/docbook-backend/'
}
var url = idMapping[(window.location.hash || '').substr(1)] || idMapping['']
window.location.href = (url.substr(0, 8) === 'https://' ? '' : 'https://docs.asciidoctor.org') + url
