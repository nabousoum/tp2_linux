Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"
  
  # Définir le nom de la machine affichée dans VirtualBox
  config.vm.provider "virtualbox" do |vb|
    vb.name = "TP-DevOps-Linux"
  end

  # Forwarding des ports
  config.vm.network "forwarded_port", guest: 80, host: 8080    # Nginx
  config.vm.network "forwarded_port", guest: 3306, host: 3306  # MySQL
  
  # Provisioning
  config.vm.provision "shell", path: "provision.sh"
end
