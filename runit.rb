dep 'runit.managed' do
  installs { via :apt, 'runit' }
  provides 'runit'
end

dep 'runit-configured' do
  requires [
    'runit.managed',
    'runit-symlinked'
  ]
end

dep 'runit-symlinked' do
  met? {
    '/etc/sv/finish'.p.exists?
  }
  
  meet {
    render_erb "templates/runit/finish.erb", :to => "/etc/sv/finish".p
    shell('chmod +x /etc/sv/finish')
  }
end
