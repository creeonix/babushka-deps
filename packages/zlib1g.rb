dep 'zlib1g.managed' do
  installs { via :apt, 'zlib1g' }

  provides []
end