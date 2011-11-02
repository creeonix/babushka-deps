dep 'openssl.managed' do
  installs { via :apt, 'openssl' }

  provides []
end

dep 'libssl-dev.managed' do
  installs { via :apt, 'libssl-dev' }

  provides []
end