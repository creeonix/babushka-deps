dep 'build-essential.managed' do
  installs { via :apt, 'build-essential' }

  provides []
end