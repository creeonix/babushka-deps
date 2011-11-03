dep 'postgres-backports', :version do
  requires [ 'debian-backports-configured', 'set.locale' ]

  version.default!('9.0')

  met? {
    shell("aptitude show postgresql-#{version}")[/State\: installed/]
  }
  
  meet {
    log "Installing PostgreSQL #{version} ..."
    shell "apt-get install -y -t squeeze-backports postgresql-#{version} postgresql-client-#{version} postgresql-contrib-#{version} postgresql-plperl-#{version} libpq-dev"
 }
end

dep 'postgres access', :username do
  requires 'postgres-backports'
  met? { !sudo("echo '\\du' | #{which 'psql'}", :as => 'postgres').split("\n").grep(/^\W*\b#{username}\b/).empty? }
  meet { sudo "createuser -SdR #{username} -W", :as => 'postgres' }
end

dep 'existing postgres db', :username, :db_name do
  requires 'postgres access'.with(username)
  met? {
    !shell("psql -l", :as => 'postgres') {|shell|
      shell.stdout.split("\n").grep(/^\s*#{db_name}\s+\|/)
    }.empty?
  }
  meet {
    shell "createdb -O '#{username}' '#{db_name}'", :as => 'postgres'
  }
end
