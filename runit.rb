dep 'runit.managed' do
  installs { via :apt, 'runit' }
  provides 'runit'
end

dep 'runit-configured' do
  requires [
    'runit.managed',
    'runit-symlinked'
  ]
  
  met? {
    
  }
  
  meet {
    
  }
end

dep 'runit-symlinked' do
  met? {
    '/etc/sv/finish'.p.exists?
  }
  
  meet {
    render_erb "templates/runit/bashrc.erb", :to => "~/.bashrc".p
    shell('chmod +x /etc/sv/finish')
  }
end
