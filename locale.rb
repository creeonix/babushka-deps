dep 'locales-generated' do
  requires 'locale-gen.config_copied'
  
  met? {
    @locales_generated || false
  }
  
  meet {
    sudo 'locale-gen', :log => true
    @locales_generated = true
  }
end

dep 'locale-default.config_copied' do
  path '/etc/default/locale'
  source 'configs/locale'
  should_sudo true
  should_replace true
  owner 'root:root'
end
