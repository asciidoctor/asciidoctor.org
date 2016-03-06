# This file is a rake build file. The purpose of this file is to simplify
# setting up and using Awestruct. It's not required to use Awestruct, though it
# does save you time (hopefully). If you don't want to use rake, just ignore or
# delete this file.
#
# If you're just getting started, execute this command to install Awestruct and
# the libraries on which it depends:
#
#  rake setup
#
# The setup task installs the necessary libraries according to which Ruby
# environment you are using. If you want the libraries kept inside the project,
# execute this command instead:
#
#  rake setup[local]
#
# IMPORTANT: To install gems, you'll need development tools on your machine,
# which include a C compiler, the Ruby development libraries and some other
# development libraries as well.
#
# There are also tasks for running Awestruct. The build will auto-detect
# whether you are using Bundler and, if you are, wrap calls to awestruct in
# `bundle exec`.
#
# To run in Awestruct in development mode, execute:
#
#  rake
#
# To clean the generated site before you build, execute:
#
#  rake clean preview
#
# To do a full build when previewing, execute:
#
#  rake clean gen preview
#
# To deploy using the production profile, execute:
#
#  rake deploy
#
# To get a list of all tasks, execute:
#
#  rake -T
#
# Now you're Awestruct with rake!

$use_bundle_exec = true
$install_gems = ['awestruct -v "0.5.5"', 'rb-inotify -v "~> 0.9.0"']
$awestruct_cmd = nil
task :default => :preview

desc 'Setup the environment to run Awestruct'
task :setup, [:env] => :init do |task, args|
  next if !which('awestruct').nil?

  if File.exist? 'Gemfile'
    if args[:env] == 'local'
      require 'fileutils'
      FileUtils.remove_file 'Gemfile.lock', true
      FileUtils.remove_dir '.bundle', true
      system 'bundle install --binstubs=_bin --path=.bundle'
    else
      system 'bundle install'
    end
  else
    if args[:env] == 'local'
      $install_gems.each do |gem|
        msg "Installing #{gem}..."
        system "gem install --bindir=_bin --install-dir=.bundle #{gem}"
      end
    else
      $install_gems.each do |gem|
        msg "Installing #{gem}..."
        system "gem install #{gem}"
      end
    end
  end
  msg 'Run awestruct using `awestruct` or `rake`'
  # Don't execute any more tasks, need to reset env
  exit 0
end

desc 'Update the environment to run Awestruct'
task :update => :init do
  if File.exist? 'Gemfile'
    system 'bundle update'
  else
    system 'gem update awestruct'
  end
  # Don't execute any more tasks, need to reset env
  exit 0
end

desc 'Generate and preview the site locally using the specified profile (default: development)'
task :preview, [:profile] => :check do |task, args|
  profile = args[:profile] || 'development'
  profile = 'production' if profile == 'prod'
  run_awestruct %(-P #{profile} -a --generate-on-access --livereload -s)
end

# provide a serve task for those used to Jekyll commands
desc 'An alias to the preview task'
task :serve => :preview

desc 'Generate the site using the specified profile (default: development)'
task :gen, [:profile] => :check do |task, args|
  profile = args[:profile] || 'development'
  profile = 'production' if profile == 'prod'
  run_awestruct %(-P #{profile} -g --force)
end

desc 'Push local commits to origin/master'
task :push do
  system 'git push origin master'
end

desc 'Generate the site and deploy to production'
task :deploy => [:push, :check] do
  run_awestruct '-P production -g --force'
  #gen_rdoc
  run_awestruct '-P production --deploy'
end

desc 'Generate site from Travis CI and, if not a pull request, publish site to production (GitHub Pages)'
task :travis do
  # force use of bundle exec in Travis environment
  $use_bundle_exec = true
  # if this is a pull request, do a simple build of the site and stop
  if ENV['TRAVIS_PULL_REQUEST'].to_s.to_i > 0
    msg 'Pull request detected. Executing build only.'
    run_awestruct '-P production -g --force', :spawn => false
    next
  end

  require 'yaml'
  require 'fileutils'

  # TODO use the Git library for these commands rather than system
  repo = %x(git config remote.origin.url).gsub(/^git:/, 'https:')
  system "git remote set-url --push origin #{repo}"
  system 'git remote set-branches --add origin gh-pages'
  system 'git fetch -q'
  # FIXME don't need to set user.name & user.email if we encrypt token using intended author's GitHub identity
  system "git config user.name '#{ENV['GIT_N']}'"
  system "git config user.email '#{ENV['GIT_E']}'"
  system 'git config credential.helper "store --file=.git/credentials"'
  # CREDENTIALS assigned by a Travis CI Secure Environment Variable
  # see http://about.travis-ci.org/docs/user/build-configuration/#Secure-environment-variables for details
  File.open('.git/credentials', 'w') {|f| f.write("https://#{ENV['GH_U']}:#{ENV['GH_T']}@github.com") }
  set_pub_dates 'master'
  system 'git branch gh-pages origin/gh-pages'
  run_awestruct '-P production -g --force -q', :spawn => false
  IO.write '_site/.nojekyll', ''
  #gen_rdoc
  run_awestruct '-P production --deploy', :spawn => false
  File.delete '.git/credentials'
  system 'git status'
end

desc "Assign publish dates to news entries"
task :setpub do
  set_pub_dates 'master'
end

desc 'Clean out generated site and temporary files'
task :clean, :spec do |task, args|
  require 'fileutils'
  dirs = ['.awestruct', '.sass-cache', '_site']
  if args[:spec] == 'all'
    dirs << '_tmp'
  end
  dirs.each do |dir|
    FileUtils.remove_dir dir unless !File.directory? dir
  end
end

# Perform initialization steps, such as setting up the PATH
task :init do
  # Detect using gems local to project
  if File.exist? '_bin'
    ENV['PATH'] = "_bin#{File::PATH_SEPARATOR}#{ENV['PATH']}"
    ENV['GEM_HOME'] = '.bundle'
  end
end

desc 'Check to ensure the environment is properly configured'
task :check => :init do
  unless File.exist? 'Gemfile'
    if which('awestruct').nil?
      msg 'Could not find awestruct.', :warn
      msg 'Run `rake setup` or `rake setup[local]` to install from RubyGems.'
      # Enable once the rubygem-awestruct RPM is available
      #msg 'Run `sudo yum install rubygem-awestruct` to install via RPM. (Fedora >= 18)'
      exit 1
    else
      $use_bundle_exec = false
      next
    end
  end

  begin
    require 'bundler'
    Bundler.setup
  rescue LoadError
    $use_bundle_exec = false
  rescue StandardError => e
    msg e.message, :warn
    if which('awestruct').nil?
      msg 'Run `rake setup` or `rake setup[local]` to install required gems from RubyGems.'
    else
      msg 'Run `rake update` to install additional required gems from RubyGems.'
    end
    exit e.status_code
  end
end

# Test rendered HTML files to make sure they’re accurate.
def run_proofer
  require 'html/proofer'
  HTML::Proofer.new('./_site', {
    # TODO: only ignore '/feed.atom', /^\/rdoc\// for local build
    href_ignore: ['#', '/feed.atom', /^\/rdoc\//, /^irc:\//, /^\\\\/, /^http:\/\/www.amazon.com\/gp\/feature.html/],
    ssl_verifypeer: true,
    #parallel: {
    #  in_processes: 1
    #}
  }).run
end

task :lint do
  run_proofer
end

# Execute Awestruct
def run_awestruct(args, opts = {})
  cmd = "#{$use_bundle_exec ? 'bundle exec ' : ''}awestruct #{args}"
  if RUBY_VERSION < '1.9'
    opts[:spawn] = false
  else
    opts[:spawn] ||= true
  end

  if opts[:spawn]
    puts cmd
    pid = spawn cmd
    Signal.trap(:INT) {
      # wait for rack server to receive signal and shutdown
      Process.wait pid
      # now we go down
      exit
    }
    Process.wait pid
  else
    sh cmd
  end

=begin
  WINDOWS = RbConfig::CONFIG['host_os'] =~ /mswin|mingw/

  if opts[:spawn]
    puts cmd
    spawn_opts = {}
    spawn_opts[:pgroup] = 0 unless WINDOWS
    spawn_opts[:new_pgroup] = 0 if WINDOWS
    pid = spawn cmd, spawn_opts
    Signal.trap(:INT) {
      # only attempt to kill if running under a different pgrp
      if Process.getpgrp != Process.getpgid(pid)
        Process.kill(:INT, pid)
      # otherwise, just wait for it to receive its signal
      else
        Process.wait pid
      end
      exit
    }
    Process.wait pid
  else
    sh cmd
  end
=end
end

# A cross-platform means of finding an executable in the $PATH.
# Respects $PATHEXT, which lists valid file extensions for executables on Windows
#
#  which 'awestruct'
#  => /usr/bin/awestruct
def which(cmd, opts = {})
  unless $awestruct_cmd.nil? || opts[:clear_cache]
    return $awestruct_cmd
  end

  $awestruct_cmd = nil
  exts = ENV['PATHEXT'] ? ENV['PATHEXT'].split(';') : ['']
  ENV['PATH'].split(File::PATH_SEPARATOR).each do |path|
    exts.each do |ext|
      candidate = File.join path, "#{cmd}#{ext}"
      if File.executable? candidate
        $awestruct_cmd = candidate
        return $awestruct_cmd
      end
    end
  end
  return $awestruct_cmd
end

# Print a message to STDOUT
def msg(text, level = :info)
  case level
  when :warn
    puts "\e[31m#{text}\e[0m"
  else
    puts "\e[33m#{text}\e[0m"
  end
end

def gen_rdoc
  require 'fileutils'
  asciidoctor_dir = %x(bundle show asciidoctor).chomp
  asciidoctor_ver = asciidoctor_dir.split('-').last
  system %(rdoc -m README.asciidoc -t "API Documentation for Asciidoctor #{asciidoctor_ver}" --markup tomdoc -o rdoc README.* lib), :chdir => asciidoctor_dir
  FileUtils.rm "#{asciidoctor_dir}/rdoc/created.rid"
  FileUtils.mv "#{asciidoctor_dir}/rdoc", '_site/rdoc'
end

# FIXME don't assign pub dates to post if it's a draft!!
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
        b.remote = 'origin/master'
        b.create
        b.checkout
      end
      repo.add(e)
      repo.commit "Set publish date of post #{e} [ci skip]"
      do_commit = true
    end

    if do_commit
      repo.push('origin', branch)
    end
  end
end
