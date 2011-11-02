meta :rvm do
  def user
    shell('whoami')
  end

  def group
    user
  end

  def home
    "~/".p
  end

  def rubyver
    "1.9.2"
  end

  def rvm args
    login_shell "#{home}/.rvm/bin/rvm #{args}", :log => args['install'], :as => user
  end

  def has_gem?(name, version = nil)
    rsp = rvm("gem list #{name}")

    version.nil? || version.empty? ? rsp[name] : rsp["#{name} (#{version})"]
  end

  def install_gem(name, version = nil, ruby = rubyver)
    version.nil? || version.empty? ?
      rvm("#{ruby} do gem install #{name}") :
      rvm("#{ruby} do gem install #{name} --version #{version}")
  end

  def gem_path(gem_name)
    env_info.val_for('INSTALLATION DIRECTORY') + "/gems/" + gem_name + "-" + version(gem_name)
  end

  def ruby_wrapper_path
    matches = env_info.val_for('RUBY EXECUTABLE').match(/[^\/]*(.*rvm\/)rubies\/([^\/]*)/)
    "#{matches[1]}wrappers/#{matches[2]}/ruby"
  end

  private

  def env_info
    @_cached_env_info ||= rvm('gem env')
  end

  def version(gem_name)
    spec = YAML.parse(rvm("gem specification #{gem_name}"))
    spec.select("/version/version")[0].value
  end

  template {
    requires 'rvm-installed'
  }
end
