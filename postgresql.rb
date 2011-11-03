dep 'postgresql-configured' do
  
  requires [
    'admin-can-full-sudo',
    'set.locale',
    'postgres.managed'
  ]

  def pg_version
    (shell('psql --version').val_for('psql (PostgreSQL)')[/^\d\.\d/]) if which('psql')
  end

  # source 'configs/pgsql/pg_hba.conf'
  # path "/etc/postgresql/#{pg_version}/main/pg_hba.conf"
  # should_sudo true
  # owner 'postgres:postgres'
  # access_rights 640

  # setup {
  #   sudo "rm -rf #{path}"
  # }

  after {
    sudo "/etc/init.d/postgresql-#{pg_version} restart"
  }
  
end
