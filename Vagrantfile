# -*- mode: ruby -*-
# vi: set ft=ruby :
# In order to add hosts to virtual box, please run :
# vagrant up
# In order to connect to the server
# ssh vagrant@192.168.33.10
# password is vagrant

current_version = Gem::Version.new(Vagrant::VERSION)
windows_version = Gem::Version.new("1.6.0")

hosts_ubuntu = {
  "jenkins-slave-create-image-docker" => "192.168.33.10",
#  "host1" => "192.168.33.11",
#  "host2" => "192.168.33.12"
}

hosts_solaris = {
  "solaris" => "192.168.34.10",
#  "host1" => "192.168.33.11",
#  "host2" => "192.168.33.12"
}

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  #config.vm.network "public_network"

  hosts_ubuntu.each do |name, ip|
    config.vm.define name do |machine|
      #machine.vm.box = "precise32"
      ##machine.vm.box_url = "http://files.vagrantup.com/precise32.box"
      #machine.vm.box_url = "http://download.parallels.com/desktop/vagrant/precise64.box"
      #machine.vm.box = "saucy64"
      #machine.vm.box_url = "https://cloud-images.ubuntu.com/vagrant/saucy/current/saucy-server-cloudimg-i386-vagrant-disk1.box"
      #machine.vm.box_url = "http://download.parallels.com/desktop/vagrant/saucy64.box"
      machine.vm.box = "trusty64"
      #machine.vm.box_url = "https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-i386-vagrant-disk1.box"
      machine.vm.box_url = "https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box"
      #machine.vm.box_url = "ubuntu/trusty64"

      machine.vm.hostname = "%s.example.org" % name
      machine.vm.network :private_network, ip: ip
      # Create a forwarded port mapping which allows access to a specific port
      # within the machine from a port on the host machine.
      config.vm.network :forwarded_port, guest: 8080, host: 8080, auto_correct:true
      machine.vm.provider "virtualbox" do |v|
          v.name = name
          v.customize ["modifyvm", :id, "--memory", 1024]
          # v.customize ["modifyvm", :id, "--memory", "4096", "--cpus", "4"]
      end

      #config.vm.provider :libvirt do |libvirt|
        #libvirt.driver = "qemu"
        #libvirt.host = "example.com"
        #libvirt.connect_via_ssh = true
        #libvirt.username = "root"
        #libvirt.storage_pool_name = "default"
      #end

      #https://docs.vagrantup.com/v2/provisioning/basic_usage.html
      Vagrant::Config.run do |prov|
        #prov.vm.provision :shell, :path => "test.sh"
        prov.vm.provision_run :always
        # :once or :always with :once being the default
      end

      config.vm.provision "ansible" do |ansible|
        #see https://docs.vagrantup.com/v2/provisioning/ansible.html
       ansible.playbook = "jenkins-slave-create-image-docker.yml"
       ansible.inventory_path = "hosts-vagrant"
       ansible.verbose = "vvvv"
       ansible.sudo = true
       ansible.host_key_checking = false
       ansible.extra_vars = { ansible_ssh_user: 'vagrant' }
       #ansible.extra_vars = {
       #  ntp_server: "pool.ntp.org",
       #  nginx: {
       #   port: 8008,
       #   workers: 4
       #  }
       #}
       # Disable default limit (required with Vagrant 1.5+)
       ansible.limit = 'all'
      end

      #config.vm.provision "docker" do |docker|
      #  docker.build_image "/vagrant/app"
      #end
      #config.vm.provision "docker",
      #   images: ["ubuntu"]
      #end
    end
  end

  #solaris11
  #
  #hosts_solaris.each do |name, ip|
  #  config.vm.define name do |machine|
  #    machine.vm.box = "solaris11"
  #    #machine.vm.box_url = "http://www.benden.us/vagrant/solaris-11.1.box"
  #    machine.vm.box_url = "solaris-11.1.box"
  #    
  #    machine.vm.hostname = "%s.example.org" % name
  #    machine.vm.network :private_network, ip: ip
  #    # Create a forwarded port mapping which allows access to a specific port
  #    # within the machine from a port on the host machine.
  #    config.vm.network :forwarded_port, guest: 8080, host: 8080, auto_correct:true
  #    
  #    machine.vm.provider "virtualbox" do |v|
  #        v.name = name
  #        v.customize ["modifyvm", :id, "--memory", 1024]
  #        # v.customize ["modifyvm", :id, "--memory", "4096", "--cpus", "4"]
  #    end
  #  end
  #end

  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  #config.vm.box = "base"

  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  # config.vm.box_url = "http://domain.com/path/to/above.box"

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network :forwarded_port, guest: 80, host: 8080

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network :private_network, ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network :public_network

  # If true, then any SSH connections made will enable agent forwarding.
  # Default value: false
  # config.ssh.forward_agent = true

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider :virtualbox do |vb|
  #   # Don't boot with headless mode
  #   vb.gui = true
  #
  #   # Use VBoxManage to customize the VM. For example to change memory:
  #   vb.customize ["modifyvm", :id, "--memory", "1024"]
  # end
  #
  # View the documentation for the provider you're using for more
  # information on available options.

  # Enable provisioning with Puppet stand alone.  Puppet manifests
  # are contained in a directory path relative to this Vagrantfile.
  # You will need to create the manifests directory and a manifest in
  # the file base.pp in the manifests_path directory.
  #
  # An example Puppet manifest to provision the message of the day:
  #
  # # group { "puppet":
  # #   ensure => "present",
  # # }
  # #
  # # File { owner => 0, group => 0, mode => 0644 }
  # #
  # # file { '/etc/motd':
  # #   content => "Welcome to your Vagrant-built virtual machine!
  # #               Managed by Puppet.\n"
  # # }
  #
  # config.vm.provision :puppet do |puppet|
  #   puppet.manifests_path = "manifests"
  #   puppet.manifest_file  = "site.pp"
  # end

  # Enable provisioning with chef solo, specifying a cookbooks path, roles
  # path, and data_bags path (all relative to this Vagrantfile), and adding
  # some recipes and/or roles.
  #
  # config.vm.provision :chef_solo do |chef|
  #   chef.cookbooks_path = "../my-recipes/cookbooks"
  #   chef.roles_path = "../my-recipes/roles"
  #   chef.data_bags_path = "../my-recipes/data_bags"
  #   chef.add_recipe "mysql"
  #   chef.add_role "web"
  #
  #   # You may also specify custom JSON attributes:
  #   chef.json = { :mysql_password => "foo" }
  # end

  # Enable provisioning with chef server, specifying the chef server URL,
  # and the path to the validation key (relative to this Vagrantfile).
  #
  # The Opscode Platform uses HTTPS. Substitute your organization for
  # ORGNAME in the URL and validation key.
  #
  # If you have your own Chef Server, use the appropriate URL, which may be
  # HTTP instead of HTTPS depending on your configuration. Also change the
  # validation key to validation.pem.
  #
  # config.vm.provision :chef_client do |chef|
  #   chef.chef_server_url = "https://api.opscode.com/organizations/ORGNAME"
  #   chef.validation_key_path = "ORGNAME-validator.pem"
  # end
  #
  # If you're using the Opscode platform, your validator client is
  # ORGNAME-validator, replacing ORGNAME with your organization name.
  #
  # If you have your own Chef Server, the default validation client name is
  # chef-validator, unless you changed the configuration.
  #
  #   chef.validation_client_name = "ORGNAME-validator"
end
