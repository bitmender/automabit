class Ubuntu < Thor
  include Thor::Shell

  namespace :system
  desc "install", "use sudo apt-get to install system package"
  def install(package)
      puts "Installing via system: #{package}"
      system "sudo apt-get install #{package}"
  end

  desc "update_all", "apt-get update, upgrade, and dist-upgrade"
  def update_all
    system "sudo apt-get update && sudo apt-get -y upgrade && sudo apt-get -y dist-upgrade"
  end

  desc "get_daily_server_iso", "download the current daily Ubuntu server cd"
  def get_daily_server_iso
    today = Date.today.strftime('%Y-%m-%d')
    system "curl -v -o ~/Downloads/quantal-server-amd64-#{today}.iso http://cdimage.ubuntu.com/ubuntu-server/daily/current/quantal-server-amd64.iso"
  end

  desc "sudo_pw_disable", "DIsable password prompt for users in sudo group"
  def sudo_pw_disable
      if yes?("Setting %sudo line to: '%sudo  ALL=NOPASSWD: ALL'\n
              Replace the sudoers file?")
        system "sudo cp tasks/templates/sudoers /etc/sudoers"
      end
  end
end

