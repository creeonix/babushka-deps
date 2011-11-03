dep 'postgres.managed', :version do
  version.default!('9.0')
  
  requires [ 'debian-backports-configured', 'set.locale' ]

  installs { via :apt, "postgresql-#{owner.version}", "libpq-dev" }

  provides "psql >= #{version}"
end