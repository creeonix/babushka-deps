dep 'libreadline6.managed' do
  installs { via :apt, 'libreadline6' }

  provides []
end

dep 'libreadline6-dev.managed' do
  installs { via :apt, 'libreadline6-dev' }

  provides []
end