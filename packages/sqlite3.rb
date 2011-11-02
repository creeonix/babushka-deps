dep 'sqlite3.managed' do
  installs { via :apt, 'sqlite3' }

  provides []
end

dep 'sqlite3-dev.managed' do
  installs { via :apt, 'libsqlite3-dev' }

  provides []
end
