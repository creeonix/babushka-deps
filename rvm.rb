dep 'rvm-requirements' do
  requires [ 
    'build-essential.managed',
    'bison.managed',
    'openssl.managed',
    'libreadline6.managed',
    'libreadline6-dev.managed',
    'curl.managed',
    'zlib1g.managed',
    'libssl-dev.managed',
    'libyaml-dev.managed',
    'sqlite3.managed',
    'sqlite3-dev.managed',
    'libxml2-dev.managed',
    'libxslt1-dev.managed',
    'postgresql.managed',
    'gemrc'
  ]
end

dep 'rvm-devel-minimal' do
  requires [
    'mc-configured',
    'rvm-requirements',
    'default-ruby.rvm',
    'bundler.rvm'
  ]
end

dep 'rvm-installed' do
  requires_when_unmet 'rvm-requirements'

  met? {
    login_shell('type rvm | head -1')['rvm is a function']
  }

  meet {
    log_shell "Installing rvm", %{bash -c "`curl -s https://raw.github.com/wayneeseguin/rvm/master/binscripts/rvm-installer`"}, :sudo => true
    # render_erb "configs/bashrc.erb", :to => "~/.bashrc".p
  }
end

dep 'default-ruby.rvm' do
  met? {
    rvm("list").include?(rubyver) &&
    login_shell('ruby --version', :as => user)["ruby #{rubyver}"]
  }

  meet {
    File.open("#{home}/.curlrc", "w") {|f| f.puts "-sk"}
    rvm("install #{rubyver}")
    shell "rm #{home}/.curlrc"
    rvm("use #{rubyver} --default")
  }
end

dep 'bundler.rvm' do
  requires 'default-ruby.rvm'

  met? { has_gem?("bundler") }
  meet { install_gem("bundler") }
end

dep 'unicorn.rvm' do
  requires 'default-ruby.rvm'

  met? { has_gem?("unicorn", "4.1.1") }
  meet { install_gem("unicorn", "4.1.1") }
end

dep 'rails.rvm' do
  requires 'default-ruby.rvm'

  met? { has_gem?("rails", "3.0.10") }
  meet { install_gem("rails", "3.0.10") }
end

dep 'passenger.rvm' do
  requires 'default-ruby.rvm'

  met? { has_gem?("passenger") }
  meet { install_gem("passenger") }
end

dep 'multi_json.rvm' do
  requires 'default-ruby.rvm'

  met? { has_gem?("multi_json", "1.0.3") }
  meet { install_gem("multi_json","1.0.3") }
end

dep 'multi_xml.rvm' do
  requires 'default-ruby.rvm'

  met? { has_gem?("multi_xml", "0.3.0") }
  meet { install_gem("multi_xml", "0.3.0") }
end

dep 'rack.rvm' do
  requires 'default-ruby.rvm'

  met? { has_gem?("rack", "1.2.3") }
  meet { install_gem("rack", "1.2.3") }
end

dep 'rack-jsonp.rvm' do
  requires 'default-ruby.rvm'

  met? { has_gem?("rack-jsonp", "1.2.0") }
  meet { install_gem("rack-jsonp", "1.2.0") }
end

dep 'grape.rvm' do
  requires 'default-ruby.rvm'

  met? { has_gem?("grape", "0.1.5") }
  meet { install_gem("grape", "0.1.5") }
end

dep 'daemons.rvm' do
  requires 'default-ruby.rvm'

  met? { has_gem?("daemons") }
  meet { install_gem("daemons") }
end
