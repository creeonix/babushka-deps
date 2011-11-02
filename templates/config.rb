meta 'config_rendered' do
  accepts_value_for :path
  accepts_value_for :template
  accepts_value_for :should_sudo, false
  accepts_value_for :should_replace, false
  accepts_value_for :owner, shell('whoami')
  accepts_value_for :access_rights, 644

  template {
    met? {
      @should_replace = should_replace if @should_replace.nil?
      File.exists?(path) && File.stat(path).size > 0 && !@should_replace
    }

    meet {
      render_erb template, :to => path, :sudo => should_sudo
      sudo "chown #{owner} #{path}"
      sudo "chmod #{access_rights} #{path}"

      @should_replace = false
    }
  }
end

meta 'config_copied' do
  accepts_value_for :path
  accepts_value_for :source
  accepts_value_for :should_sudo, false
  accepts_value_for :should_replace, false
  accepts_value_for :owner, shell('whoami')
  accepts_value_for :access_rights, 644

  template {
    met? {
      @should_replace = should_replace if @should_replace.nil?
      File.exists?(path) && File.stat(path).size > 0 && !@should_replace
    }

    meet {
      log_shell "Setting up #{path}", "cp #{erb_path_for(source)} #{path}", :sudo => should_sudo
      sudo "chown #{owner} #{path}"
      sudo "chmod #{access_rights} #{path}"

      @should_replace = false
    }
  }
end

meta 'config_symlinked' do
  accepts_value_for :path
  accepts_value_for :source
  accepts_value_for :should_sudo, false

  template {
    met? {
      File.exists?(path) && File.symlink?(path)
    }

    meet {
      log_shell "Setting up symlink #{source} -> #{path}", "ln -s #{source} #{path}", :sudo => should_sudo
    }
  }
end