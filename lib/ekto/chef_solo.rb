module Ekto
  class ChefSolo
    def initialize(machine)
      @machine = machine
    end

    def install
      commands = <<-COMMANDS
sudo apt-get update
sudo apt-get --yes dist-upgrade
sudo apt-get --yes install curl -y
curl -L https://www.opscode.com/chef/install.sh | sudo bash
COMMANDS
      commands.lines.each do |line|
        @machine.connect!(line)
      end
    end
  end
end
#sudo mkdir -p /etc/apt/sources.list.d
#sudo sh -c 'echo "deb http://apt.opscode.com/ squeeze-0.10 main" >  /etc/apt/sources.list.d/opscode.list'
#sudo mkdir -p /etc/apt/trusted.gpg.d
#gpg --keyserver keys.gnupg.net --recv-keys 83EF826A
#gpg --export packages@opscode.com | sudo tee /etc/apt/trusted.gpg.d/opscode-keyring.gpg > /dev/null
#sudo apt-get update
#sudo apt-get install opscode-keyring
#sudo apt-get upgrade
#echo "chef chef/chef_server_url string none" | sudo debconf-set-selections && sudo apt-get install chef -y
