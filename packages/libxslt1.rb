dep 'libxslt1-dev.managed' do
  installs { via :apt, 'libxslt1-dev' }

  provides []
end