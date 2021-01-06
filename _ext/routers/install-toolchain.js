var idMapping = {
  '': '/asciidoctor/latest/install/',
  'system-requirements': '/asciidoctor/latest/install/supported-platforms/',
  'installing-the-asciidoctor-rubygem': '/asciidoctor/latest/install/ruby-packaging/',
  'install-using-yum-or-dnf-on-fedora': '/asciidoctor/latest/install/linux-packaging/#dnf',
  'install-using-apt-get-on-debian-or-ubuntu': '/asciidoctor/latest/install/linux-packaging/#apt',
  'install-using-apk-on-alpine-linux': '/asciidoctor/latest/install/linux-packaging/#apk',
  'upgrading-the-asciidoctor-ruby-gem': '/asciidoctor/latest/install/ruby-packaging/#gem-update',
  'text-editors-and-syntax-highlighting': '/asciidoctor/latest/tooling/'
}
var hash = window.location.hash
window.location.href = 'https://docs.asciidoctor.org' + ((hash && idMapping[hash.slice(1)]) || idMapping[''])
