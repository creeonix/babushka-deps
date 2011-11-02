dep 'postgresql.managed' do
  installs { via :apt, 'postgresql' }
  provides [
    'psql',
    'createuser',
    'createdb',
    'dropdb',
    'dropuser'
  ]
end