dep 'admin-can-full-sudo' do
  met? { !sudo('cat /etc/sudoers').split("\n").grep(/^%admin ALL=\(ALL\) NOPASSWD\: ALL/).empty? }
  meet { append_to_file "%admin ALL=(ALL) NOPASSWD: ALL", '/etc/sudoers', :sudo => true }
end