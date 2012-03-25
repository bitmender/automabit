
class Ubuntu < Thor
  namespace :system
  desc "install", "use sudo apt-get to install system package"
  def install(package)
    system "sudo apt-get install #{package}" 
  end
end

