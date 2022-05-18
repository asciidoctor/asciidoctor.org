var idMapping = {
  '': '/pdf-converter/latest/',
  'highlights': '/pdf-converter/latest/features/#highlights',
  'known-limitations': '/pdf-converter/latest/features/#known-limitations',
  'prerequisites': '/pdf-converter/latest/install/#prerequisites',
  'system-encoding': '/pdf-converter/latest/install/#system-encoding',
  'getting-started': '/pdf-converter/latest/install/',
  'install-the-published-gem': '/pdf-converter/latest/install/#install-asciidoctor-pdf',
  'installation-troubleshooting': '/pdf-converter/latest/install/#troubleshooting',
  'themes': '/pdf-converter/latest/theme/',
  'support-for-non-latin-languages': '/pdf-converter/latest/theme/font-support/#support-for-non-latin-languages',
  'font-based-icons': '/pdf-converter/latest/icons/',
  'image-paths': '/pdf-converter/latest/image-paths-and-formats/',
  'image-scaling': '/pdf-converter/latest/image-scaling/',
  'background-image-positioning': '/pdf-converter/latest/background-images/',
  'fonts-in-svg-images': '/pdf-converter/latest/image-paths-and-formats/#svg',
  'supporting-additional-image-file-formats': '/pdf-converter/latest/image-paths-and-formats/#other-image-formats',
  'crafting-interdocument-xrefs': '/pdf-converter/latest/interdocument-xrefs/',
  'stem-support': '/pdf-converter/latest/stem/',
  'skipping-passthrough-content': '/pdf-converter/latest/passthrough-content/',
  'shaded-blocks-and-performance': '/pdf-converter/latest/breakable-and-unbreakable/',
  'autofitting-text': '/pdf-converter/latest/autofit-text/',
  'autowidth-tables': '/pdf-converter/latest/autowidth-tables/',
  'printing-page-ranges': '/pdf-converter/latest/page-numbers/#printing-page-ranges',
  'title-page': '/pdf-converter/latest/title-page/',
  'table-of-contents': '/pdf-converter/latest/toc/',
  'index-catalog': '/pdf-converter/latest/index-catalog/',
  'optimizing-the-generated-pdf': '/pdf-converter/latest/optimize-pdf/'
}
var hash = window.location.hash
var url = idMapping[hash.substr(1)] || idMapping[''].concat(hash)
window.location.href = (url.substr(0, 8) === 'https://' ? '' : 'https://docs.asciidoctor.org').concat(url)
