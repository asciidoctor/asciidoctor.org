var idMapping = {
  '': '/maven-tools/latest/',
  'maven-plugin': '/maven-tools/latest/introduction/',
  'setup': '/maven-tools/latest/plugin/goals/process-asciidoc/#setup',
  'configuration': '/maven-tools/latest/plugin/goals/process-asciidoc/#configuration',
  'built-in-attributes': '/maven-tools/latest/plugin/goals/process-asciidoc/#configuration-attributes',
  'passing-pom-properties': '/maven-tools/latest/plugin/goals/process-asciidoc/#configuration',
  'setting-boolean-values': '/maven-tools/latest/plugin/goals/process-asciidoc/#configuration-attributes',
  'command-line-configuration': '/maven-tools/latest/plugin/command-line-configuration/',
  'multiple-outputs-for-the-same-file': '/maven-tools/latest/plugin/usage/#multiple-outputs-for-the-same-file',
  'maven-site-integration': '/maven-tools/latest/site-integration/',
  'setup-2': '/maven-tools/latest/site-integration/#setup',
  'configuration-2': '/maven-tools/latest/site-integration/#configuration',
  'hacking': '/maven-tools/latest/project/contributing/#hacking',
  'building': '/maven-tools/latest/project/contributing/#hacking',
  'testing': '/maven-tools/latest/project/contributing/#testing',
  'tips-tricks': '/maven-tools/latest/plugin/tips-and-tricks/',
  'generate-your-documentation-in-separate-folders-per-version': '/maven-tools/latest/plugin/tips-and-tricks/#generate-your-documentation-in-separate-folders-per-version',
  'enable-section-numbering': '/maven-tools/latest/plugin/tips-and-tricks/#enable-section-numbering',
  'add-version-and-build-date-to-the-header': '/maven-tools/latest/plugin/tips-and-tricks/#add-version-and-build-date-to-the-header'
}
var url = idMapping[(window.location.hash || '').substr(1)] || idMapping['']
window.location.href = (url.substr(0, 8) === 'https://' ? '' : 'https://docs.asciidoctor.org') + url
