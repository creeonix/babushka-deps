dep 'postgresql-configured' do
  requires [
    'admin-can-full-sudo',
    'pg-hba.config_copied',
  ]
end

dep 'postgresql.restarted' do
  services %W( postgresql-8.4 )
end

dep 'postgresql.stopped' do
  services %W( postgresql-8.4 )
end

dep 'postgresql.started' do
  services %W( postgresql-8.4 )
end

dep 'pg-hba.config_copied' do
  
  requires [
    'locale-default.config_copied',
    'postgresql.managed'
  ]

  def pg_version
    "8.4"
  end

  source 'configs/pgsql/pg_hba.conf'
  path "/etc/postgresql/#{pg_version}/main/pg_hba.conf"
  should_sudo true
  owner 'postgres:postgres'
  access_rights 640

  setup {
    sudo "rm -rf #{path}"
  }

  after {
    sudo "/etc/init.d/postgresql-#{pg_version} restart"
  }
end
