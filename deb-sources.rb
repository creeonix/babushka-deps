dep 'debian-backports-configured' do
  met? { !sudo('cat /etc/apt/sources.list').split("\n").grep(/^deb http\:\/\/backports.debian.org\/debian-backports squeeze-backports main/).empty? }
  meet { 
    append_to_file "deb http://backports.debian.org/debian-backports squeeze-backports main", '/etc/apt/sources.list', :sudo => true
    shell 'apt-get update'
  }
end
