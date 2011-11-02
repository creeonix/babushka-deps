dep 'libxml2-dev.managed' do
  installs { via :apt, 'libxml2-dev' }

  provides []
end