
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

  desc "get_daily_server_cd", "download the current daily Ubuntu server cd"
  def get_daily_server_cd 
    system "curl -v -o ~/Download/precide-server-amd64.iso http://cdimage.ubuntu.com/ubuntu-server/daily/current/precise-server-amd64.iso"
  end
end

