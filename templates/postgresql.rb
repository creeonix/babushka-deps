meta 'pgdb' do
  accepts_value_for :db
  accepts_value_for :user

  template {
    met? {
      sudo("psql -l", :as => 'postgres')[db]
    }

    meet {
      log "Creating #{db} PostgreSQL database ..."
      sudo("createdb --template template0 --encoding SQL_ASCII --locale C -O #{user} #{db}", :as => 'postgres')
    }
  }
end

meta 'pguser' do
  accepts_value_for :user
  accepts_value_for :password
  
  template {
    met? {
      shell(%Q{ psql template1 -c "select * from pg_user;" }, :sudo => 'postgres')[user]
    }

    meet {
      log "Creating #{user} PostgreSQL user ..."
      shell("createuser -S -d -R #{user}", :sudo => 'postgres')
      shell(%Q{ psql template1 -c "ALTER USER #{user} WITH PASSWORD '#{password}';" }, :sudo => 'postgres')
    }
  }
end

meta 'pgpasswd' do
  accepts_value_for :user
  accepts_value_for :password
  accepts_value_for :db
  accepts_value_for :path, "~/.pgpass"
  
  template {
    def passwd_string(host,db,user,password)
      "#{host}:*:#{db}:#{user}:#{password}"
    end
    
    def passwd_bundle
      [ passwd_string("localhost",db,user,password),
        passwd_string("127.0.0.1",db,user,password) ].join("\n")
    end
    
    met? {
      grep(passwd_string("localhost",db,user,password), path.p) &&
      grep(passwd_string("127.0.0.1",db,user,password), path.p)
    }

    meet {
      append_to_file passwd_bundle, path
      shell "chmod 600 #{path}" # ensure PG likes the .pgpasswd
    }
  }
end
