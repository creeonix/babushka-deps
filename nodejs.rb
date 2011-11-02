dep 'nodejs.src', :version do
  version.default!('v0.4.12')
  source 'git://github.com/joyent/node.git'

  preconfigure {
    log "Checking out nodeJS #{version} ..."
    shell "git checkout #{version}"
  }

  provides "node == #{version}", 'node-waf'
end
