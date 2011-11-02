dep 'gitflow' do
  met? {
    which("git-flow")
  }

  meet {
    cd("/var/tmp") {
      log_shell(
        "Installing git-flow",
        "wget --no-check-certificate -q -O - https://github.com/nvie/gitflow/raw/develop/contrib/gitflow-installer.sh | sudo bash",
        :sudo => true
      )
    }
  }
end