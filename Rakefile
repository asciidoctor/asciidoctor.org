require 'rubygems'

task :default => :preview

desc 'Preview the site locally in development mode'
task :preview, [:flags] do |t, args|
  cmd = 'bundle exec awestruct -d'
  if (args[:flags])
    cmd = "#{cmd} #{args[:flags]}"
  end
  system cmd
end

desc 'Generate the site using the development profile'
task :gen, [:flags] do |t, args|
  cmd = 'bundle exec awestruct -P development -g'
  if (args[:flags])
    cmd = "#{cmd} #{args[:flags]}"
  end
  system cmd
end

desc 'Push local commits to origin/develop'
task :push do
  system 'git push origin develop'
end

desc 'Generate and publish site to production (GitHub Pages) from home'
task :deploy => :push do
  system 'bundle exec awestruct -P production --force -g'
  gen_rdoc
  system 'bundle exec awestruct -P production --deploy'
end

desc 'Generate site from Travis CI and, if not a pull request, publish site to production (GitHub Pages)'
task :travis do
  # if this is a pull request, do a simple build of the site and stop
  if ENV['TRAVIS_PULL_REQUEST'] == '1' || ENV['TRAVIS_PULL_REQUEST'] == 'true'
    system 'bundle exec awestruct -P production -g'
    next
  end

  require 'yaml'
  require 'fileutils'

  # TODO use the Git library for these commands rather than system
  repo = %x(git config remote.origin.url).gsub(/^git:/, 'https:')
  system "git remote set-url --push origin #{repo}"
  system 'git remote set-branches --add origin master'
  system 'git fetch -q'
  system "git config user.name '#{ENV['GIT_NAME']}'"
  system "git config user.email '#{ENV['GIT_EMAIL']}'"
  system 'git config credential.helper "store --file=.git/credentials"'
  # CREDENTIALS assigned by a Travis CI Secure Environment Variable
  # see http://about.travis-ci.org/docs/user/build-configuration/#Secure-environment-variables for details
  File.open('.git/credentials', 'w') {|f| f.write("https://#{ENV['GH_TOKEN']}:@github.com") }
  set_pub_dates 'develop'
  system 'git branch master origin/master'
  system 'bundle exec awestruct -P production -g'
  gen_rdoc
  system 'bundle exec awestruct -P production --deploy'
  File.delete '.git/credentials'
end

desc "Assign publish dates to news entries"
task :setpub do
  set_pub_dates 'develop'
end

def gen_rdoc
  require 'fileutils'
  asciidoctor_dir = %x(bundle show asciidoctor).chomp
  asciidoctor_ver = asciidoctor_dir.split('-').last
  system %(rdoc -m README.asciidoc -t "API Documentation for Asciidoctor #{asciidoctor_ver}" --markup tomdoc -o rdoc README.* lib), :chdir => asciidoctor_dir
  FileUtils.mv "#{asciidoctor_dir}/rdoc", '_site/rdoc'
end

def set_pub_dates(branch)
  require 'tzinfo'
  require 'git'
  local_tz = IO.readlines('_config/site.yml').find {|l| l.start_with?('local_tz: ') }.chomp.sub('local_tz: ', '')
  local_tz = TZInfo::Timezone.get(local_tz)

  repo = nil

  Dir['news/*.adoc'].select {|e| !e.start_with? 'news/_'}.each do |e|
    lines = IO.readlines e
    header = lines.inject([]) {|collector, l|
      break collector if l.chomp.empty?
      collector << l 
      collector
    }
  
    do_commit = false
    if !header.detect {|l| l.start_with?(':revdate: ') || l.start_with?(':awestruct-draft:') || l.start_with?(':awestruct-layout:') }
      revdate = Time.now.utc.getlocal(local_tz.current_period.utc_total_offset)
      lines[2] = "#{revdate.strftime('%Y-%m-%d')}\n"
      lines.insert(3, ":revdate: #{revdate}\n")
      File.open(e, 'w') {|f|
        f.write(lines.join)
      }
      if !repo
        repo = Git.open('.')
        b = repo.branch(branch)
        b.remote = 'origin/develop'
        b.create
        b.checkout
      end
      repo.add(e)
      repo.commit "Set publish date of post #{e}"
      do_commit = true
    end
  
    if do_commit
      repo.push('origin', branch)
    end
  end
end
