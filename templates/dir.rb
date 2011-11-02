meta 'dir' do
  accepts_value_for :path
  accepts_value_for :should_sudo, false

  template {
    met? {
      path.p.exists?
    }

    meet {
      log_shell "Creating #{path} directory", "mkdir -p #{path}", :sudo => should_sudo
    }
  }
end