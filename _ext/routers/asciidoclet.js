var idMapping = {
  '': '/asciidoclet/latest/',
  'introduction': '/asciidoclet/latest/getting-started',
  'example': '/asciidoclet/latest/getting-started/#example',
  'usage': '/asciidoclet/latest/usage/',
  'maven': '/asciidoclet/latest/usage/#maven',
  'gradle': '/asciidoclet/latest/usage/#gradle',
  'ant': '/asciidoclet/latest/usage/#ant',
  'doclet-options': '/asciidoclet/latest/options/',
  'resources-and-help': '/asciidoclet/latest/project/resources',
  'license': '/asciidoclet/latest/project/license'
}
var url = idMapping[(window.location.hash || '').substr(1)] || idMapping['']
window.location.href = (url.substr(0, 8) === 'https://' ? '' : 'https://docs.asciidoctor.org') + url
