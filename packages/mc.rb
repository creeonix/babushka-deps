require 'fileutils'

dep 'mc.managed' do
  installs { via :apt, 'mc' }
end

dep 'mc-configured' do
  requires [
    'mc.managed',
    'mc-ini.dir',
    'mc-ini.config_rendered',
    'mc-panels.config_rendered'
  ]
end

dep 'mc-ini.dir' do
  path "~/.mc"
end

dep 'mc-ini.config_rendered' do
  path "~/.mc/ini".p
  template "configs/mc/ini.erb"
  should_replace true
end

dep 'mc-panels.config_rendered' do
  path "~/.mc/panels.ini".p
  template "configs/mc/panels.ini.erb"
  should_replace true
end
