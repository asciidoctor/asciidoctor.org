var idMapping = {
  '': '/maven-tools/latest/project/contributing/',
  'hacking': '/maven-tools/latest/project/contributing/#hacking',
  'building': '/maven-tools/latest/project/contributing/#hacking',
  'testing': '/maven-tools/latest/project/contributing/#testing',
  'resources': '/maven-tools/latest/project/contributing/#testing'
}
var url = idMapping[(window.location.hash || '').substr(1)] || idMapping['']
window.location.href = (url.substr(0, 8) === 'https://' ? '' : 'https://docs.asciidoctor.org') + url
