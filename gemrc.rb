dep 'gemrc' do
  def rc
    "~/.gemrc".p
  end

  met? {
    File.exists?(rc)
  }

  meet {
    render_erb "configs/gemrc.erb", :to => rc
  }
end