meta 'git' do
  accepts_value_for :path
  accepts_value_for :repo
  accepts_value_for :should_sudo, false

  def valid?
    path.exists? && Babushka::GitRepo.new(path).exists?
  end

  def clone
    git repo, :to => path
  end

  def up_to_date?
    r = Babushka::GitRepo.new(path)
    r.repo_shell "git fetch"
    !r.behind?
  end

  def repo_shell(cmd)
    Babushka::GitRepo.new(path).repo_shell(cmd)
  end

  def git_repo
    Babushka::GitRepo.new(path)
  end

  template {
    met? {
      path.exists?
    }

    meet {
      log_shell "Creating #{path} directory", "mkdir -p #{path}", :sudo => should_sudo
    }
  }
end
