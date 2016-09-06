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
  "slave01" => "51",
#  "slave02" => "52",
#  "slave03" => "53",
#  "slave03" => "54"
}

hosts_solaris = {
  "solaris" => "192.168.34.10",
#  "host1" => "192.168.33.11",
#  "host2" => "192.168.33.12"
}

HOSTNAME_01 = "slave01"
VAGRANT_BASE_PORT_01 = "51"
VAGRANT_SSH_PORT_01 = "22" + VAGRANT_BASE_PORT_01
VAGRANT_NETWORK_IP_01 = "192.168.11." + VAGRANT_BASE_PORT_01

HOSTNAME_02 = "slave02"
VAGRANT_BASE_PORT_02 = "52"
VAGRANT_SSH_PORT_02 = "22" + VAGRANT_BASE_PORT_02
VAGRANT_NETWORK_IP_02 = "192.168.11." + VAGRANT_BASE_PORT_02

HOSTNAME_03 = "slave03"
VAGRANT_BASE_PORT_03 = "53"
VAGRANT_SSH_PORT_03 = "22" + VAGRANT_BASE_PORT_03
VAGRANT_NETWORK_IP_03 = "192.168.11." + VAGRANT_BASE_PORT_03

HOSTNAME_04 = "slave04"
VAGRANT_BASE_PORT_04 = "54"
VAGRANT_SSH_PORT_04 = "22" + VAGRANT_BASE_PORT_04
VAGRANT_NETWORK_IP_04 = "192.168.11." + VAGRANT_BASE_PORT_04

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

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
      machine.vm.network :private_network, ip: "192.168.11." + ip
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

  config.vm.define :slave01 do |vagrant|

    #vagrant.vm.box = "hfm4/centos5"
    vagrant.vm.box = "hfm4/centos6"
    #vagrant.vm.box = "hfm4/centos7"
    vagrant.vm.boot_timeout = 600

    vagrant.vm.hostname = HOSTNAME_01
    vagrant.vm.network :private_network, ip: VAGRANT_NETWORK_IP_01
    vagrant.vm.provider :virtualbox do |vb|
      vb.name = HOSTNAME_01
      #vb.customize ["modifyvm", :id, "--memory", "8192"]
      vb.memory = 8192
      vb.cpus = 4
    end

    #vagrant.vm.provision "file", source: "../keys/id_rsa", destination: "id_rsa"
    #vagrant.vm.provision "file", source: "../keys/id_rsa.pub", destination: "id_rsa.pub"
    #vagrant.vm.provision "file", source: "../keys/mgr.jenkins.pub", destination: "mgr.jenkins.pub"

    vagrant.vm.provision :shell, :path => "buildup.sh"

    #See issue vagrant forward port 22 unable to force
    #https://stackoverflow.com/questions/30669183/forwarding-the-ssh-port-fails-when-running-two-vagrant-instances-from-the-same-h
    #vagrant.vm.network "forwarded_port", guest: 22, host: 2222, id: "ssh", disabled: "true"
    vagrant.vm.network "forwarded_port", guest: 22, host: VAGRANT_SSH_PORT_01, id: 'ssh', auto_correct: "true"
    # Generate a random port number
    #r = Random.new
    #ssh_port = r.rand(1000...5000)
    #vagrant.vm.network "forwarded_port", guest: 22, host: "#{ssh_port}", id: 'ssh', auto_correct: true
    #vagrant.vm.network "forwarded_port", guest: 8380, host: 8380, auto_correct: true
    vagrant.vm.network "forwarded_port", guest: 33224, host: 33224, auto_correct: true

    # Do not use a shared folder. We will fetch sources in other ways.
    # This allows us (eventually) to export the VM and move it around.
    vagrant.vm.synced_folder ".", "/vagrant", disabled: true

    #vagrant.ssh.private_key_path = "../keys/id_rsa"
    #vagrant.ssh.forward_agent = true
    #vagrant.ssh.host = VAGRANT_NETWORK_IP_01
    #vagrant.ssh.port = VAGRANT_SSH_PORT_01
    #vagrant.ssh.forward_agent = true

    #config.vm.provision "ansible" do |ansible|
    #  #see https://docs.vagrantup.com/v2/provisioning/ansible.html
    #  ansible.playbook = "../../ansible/jenkins-UAT-slave.yml"
    #  ansible.inventory_path = "../../ansible/hosts"
    #  ansible.verbose = "vvvv"
    #  ansible.sudo = true
    #  ansible.host_key_checking = false
    #  ansible.extra_vars = { ansible_ssh_user: 'vagrant' }
    #  # Disable default limit (required with Vagrant 1.5+)
    #  ansible.limit = 'all'
    #end
  end

  config.vm.define :slave02 do |vagrant|

    #vagrant.vm.box = "hfm4/centos5"
    #vagrant.vm.box = "hfm4/centos6"
    vagrant.vm.box = "hfm4/centos7"
    vagrant.vm.boot_timeout = 600

    vagrant.vm.hostname = HOSTNAME_02
    vagrant.vm.network :private_network, ip: VAGRANT_NETWORK_IP_02
    vagrant.vm.provider :virtualbox do |vb|
      vb.name = HOSTNAME_02
      #vb.customize ["modifyvm", :id, "--memory", "8192"]
      vb.memory = 8192
      vb.cpus = 4
    end

    #vagrant.vm.provision "file", source: "../keys/id_rsa", destination: "id_rsa"
    #vagrant.vm.provision "file", source: "../keys/id_rsa.pub", destination: "id_rsa.pub"
    #vagrant.vm.provision "file", source: "../keys/mgr.jenkins.pub", destination: "mgr.jenkins.pub"

    #vagrant.vm.provision :shell, :path => "buildup.sh"

    #See issue vagrant forward port 22 unable to force
    #https://stackoverflow.com/questions/30669183/forwarding-the-ssh-port-fails-when-running-two-vagrant-instances-from-the-same-h
    #vagrant.vm.network "forwarded_port", guest: 22, host: 2222, id: "ssh", disabled: "true"
    vagrant.vm.network "forwarded_port", guest: 22, host: VAGRANT_SSH_PORT_02, id: 'ssh', auto_correct: "true"
    vagrant.vm.network "forwarded_port", guest: 33224, host: 33224, auto_correct: true

    # Do not use a shared folder. We will fetch sources in other ways.
    # This allows us (eventually) to export the VM and move it around.
    vagrant.vm.synced_folder ".", "/vagrant", disabled: true

  end

  config.vm.define :slave03 do |vagrant|

    #vagrant.vm.box = "precise32"
    ##vagrant.vm.box_url = "http://files.vagrantup.com/precise32.box"
    #vagrant.vm.box_url = "http://download.parallels.com/desktop/vagrant/precise64.box"
    #vagrant.vm.box = "saucy64"
    #vagrant.vm.box_url = "https://cloud-images.ubuntu.com/vagrant/saucy/current/saucy-server-cloudimg-i386-vagrant-disk1.box"
    #vagrant.vm.box_url = "http://download.parallels.com/desktop/vagrant/saucy64.box"
    #vagrant.vm.box = "trusty64"
    #vagrant.vm.box_url = "https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-i386-vagrant-disk1.box"
    #vagrant.vm.box_url = "https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box"
    #vagrant.vm.box_url = "ubuntu/trusty64"

    #https://atlas.hashicorp.com/ubuntu/boxes/trusty64
    vagrant.vm.box = "ubuntu/trusty64"
    #https://atlas.hashicorp.com/ubuntu/boxes/xenial64
    #vagrant.vm.box = "ubuntu/xenial64"
    vagrant.vm.boot_timeout = 600

    vagrant.vm.hostname = HOSTNAME_03
    vagrant.vm.network :private_network, ip: VAGRANT_NETWORK_IP_03
    vagrant.vm.provider :virtualbox do |vb|
      vb.name = HOSTNAME_03
      #vb.customize ["modifyvm", :id, "--memory", "8192"]
      vb.memory = 8192
      vb.cpus = 4
    end

    #vagrant.vm.provision "file", source: "../keys/id_rsa", destination: "id_rsa"
    #vagrant.vm.provision "file", source: "../keys/id_rsa.pub", destination: "id_rsa.pub"
    #vagrant.vm.provision "file", source: "../keys/mgr.jenkins.pub", destination: "mgr.jenkins.pub"

    #vagrant.vm.provision :shell, :path => "buildup.sh"

    #See issue vagrant forward port 22 unable to force
    #https://stackoverflow.com/questions/30669183/forwarding-the-ssh-port-fails-when-running-two-vagrant-instances-from-the-same-h
    #vagrant.vm.network "forwarded_port", guest: 22, host: 2222, id: "ssh", disabled: "true"
    vagrant.vm.network "forwarded_port", guest: 22, host: VAGRANT_SSH_PORT_03, id: 'ssh', auto_correct: "true"
    vagrant.vm.network "forwarded_port", guest: 33224, host: 33224, auto_correct: true

    # Do not use a shared folder. We will fetch sources in other ways.
    # This allows us (eventually) to export the VM and move it around.
    vagrant.vm.synced_folder ".", "/vagrant", disabled: true

  end

  config.vm.define :slave04 do |vagrant|

    #https://atlas.hashicorp.com/ubuntu/boxes/trusty64
    #vagrant.vm.box = "ubuntu/trusty64"
    #https://atlas.hashicorp.com/ubuntu/boxes/xenial64
    vagrant.vm.box = "ubuntu/xenial64"
    vagrant.vm.boot_timeout = 600

    vagrant.vm.hostname = HOSTNAME_04
    vagrant.vm.network :private_network, ip: VAGRANT_NETWORK_IP_04
    vagrant.vm.provider :virtualbox do |vb|
      vb.name = HOSTNAME_04
      #vb.customize ["modifyvm", :id, "--memory", "8192"]
      vb.memory = 8192
      vb.cpus = 4
    end

    #vagrant.vm.provision "file", source: "../keys/id_rsa", destination: "id_rsa"
    #vagrant.vm.provision "file", source: "../keys/id_rsa.pub", destination: "id_rsa.pub"
    #vagrant.vm.provision "file", source: "../keys/mgr.jenkins.pub", destination: "mgr.jenkins.pub"

    #vagrant.vm.provision :shell, :path => "buildup.sh"

    #See issue vagrant forward port 22 unable to force
    #https://stackoverflow.com/questions/30669183/forwarding-the-ssh-port-fails-when-running-two-vagrant-instances-from-the-same-h
    #vagrant.vm.network "forwarded_port", guest: 22, host: 2222, id: "ssh", disabled: "true"
    vagrant.vm.network "forwarded_port", guest: 22, host: VAGRANT_SSH_PORT_04, id: 'ssh', auto_correct: "true"
    vagrant.vm.network "forwarded_port", guest: 33224, host: 33224, auto_correct: true

    # Do not use a shared folder. We will fetch sources in other ways.
    # This allows us (eventually) to export the VM and move it around.
    vagrant.vm.synced_folder ".", "/vagrant", disabled: true

  end

end

#Connect doing
#from outside host
#ssh -p 2251 vagrant@test
#ssh -p 2252 vagrant@test
#ssh -p 2253 vagrant@test
#ssh -p 2254 vagrant@test
#from inside host
#ssh -p 22 vagrant@192.168.11.51
#ssh -p 22 vagrant@192.168.11.52
#ssh -p 22 vagrant@192.168.11.53
#ssh -p 22 vagrant@192.168.11.54
