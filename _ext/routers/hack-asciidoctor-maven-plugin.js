var idMapping = {
    '': '/maven-tools/latest/project/contributing/',
    'hacking': '/maven-tools/latest/project/contributing/#hacking',
    'building': '/maven-tools/latest/project/contributing/#hacking',
    'testing': '/maven-tools/latest/project/contributing/#testing',
    'resources': '/maven-tools/latest/project/contributing/#testing',
}

var hash = window.location.hash
window.location.href = 'https://docs.asciidoctor.org' + ((hash && idMapping[hash.slice(1)]) || (idMapping[''] + hash))
