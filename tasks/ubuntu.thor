
class Ubuntu < Thor
  namespace :system
  desc "install", "use sudo apt-get to install system package"
  def install(package)
    package.each do |p| 
      puts "Installing via system: #{p}"
      system "sudo apt-get install #{p}"
    end
  end

  desc "update_all", "apt-get update, upgrade, and dist-upgrade"
  def update_all
    system "sudo apt-get update && sudo apt-get upgrade && sudo apt-get dist-upgrade"
  end
end

