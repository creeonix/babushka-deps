dep 'imagemagick.managed' do
  installs { via :apt, 'imagemagick' }
  
  provides 'mogrify'
end
