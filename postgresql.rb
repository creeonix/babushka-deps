dep 'postgresql-configured' do
  requires [
    'admin-can-full-sudo',
    'pg-hba.config_copied',
    'hrtool-dev.pgpasswd',
    'hrtool-production.pgpasswd',
    'hrtool-test.pgpasswd',
    'hrtool-dev.pgdb',
    'hrtool-production.pgdb',
    'hrtool-test.pgdb'
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

dep 'hrtool.pguser' do
  user 'hrtool'
  password 'hrtoolsecret'
end

dep 'hrtool-dev.pgdb' do
  requires 'hrtool.pguser'
  
  db "hrtool_development"
  user 'hrtool'
end

dep 'hrtool-production.pgdb' do
  requires 'hrtool.pguser'
  
  db "hrtool_production"
  user 'hrtool'
end

dep 'hrtool-test.pgdb' do
  requires 'hrtool.pguser'
  
  db "hrtool_test"
  user 'hrtool'
end

dep 'hrtool-dev.pgpasswd' do
  requires 'hrtool.pguser'
  
  user 'hrtool'
  password 'hrtoolsecret'
  db "hrtool_development"
end

dep 'hrtool-production.pgpasswd' do
  requires 'hrtool.pguser'
  
  user 'hrtool'
  password 'hrtoolsecret'
  db "hrtool_production"
end

dep 'hrtool-test.pgpasswd' do
  requires 'hrtool.pguser'
  
  user 'hrtool'
  password 'hrtoolsecret'
  db "hrtool_test"
end

dep 'pg-hba.config_copied' do
  requires 'postgresql.managed'

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
