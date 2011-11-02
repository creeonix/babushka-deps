meta 'restarted' do
  accepts_list_for  :services, []

  template {

    met? {
      @services_restarted || false
    }

    meet {
      services.each do |s|
        log_shell "Restarting #{s}", "/etc/init.d/#{s} restart", :sudo => true
      end

      @services_restarted = true
    }
  }
end

meta 'stopped' do
  accepts_list_for  :services, []

  template {

    met? {
      @services_stopped || false
    }

    meet {
      services.each do |s|
        log_shell "Stopping #{s}", "/etc/init.d/#{s} stop", :sudo => true
      end

      @services_stopped = true
    }
  }
end

meta 'started' do
  accepts_list_for  :services, []

  template {

    met? {
      @services_started || false
    }

    meet {
      services.each do |s|
        log_shell "Starting #{s}", "/etc/init.d/#{s} start", :sudo => true
      end

      @services_started = true
    }
  }
end
