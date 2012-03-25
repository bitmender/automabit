
class Ubuntu < Thor
  namespace :system
  desc "install", "use sudo apt-get to install system package"
  def install(package)
    puts "Installing via system: #{package}"
    system "sudo apt-get install #{package}" 
  end

  desc "update_all", "apt-get update, upgrade, and dist-upgrade"
  def update_all
    system "sudo apt-get update && sudo apt-get upgrade && sudo apt-get dist-upgrade"
  end
end

