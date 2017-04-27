#!/bin/sh

#export VAGRANT_VAGRANTFILE=${WORKSPACE}/Scripts/ansible/roles/jenkins-slave/Vagrantfile

if [ -n "${TARGET_SLAVE}" ]; then
  echo "TARGET_SLAVE is defined"
else
  echo "Undefined build parameter: TARGET_SLAVE, use the default one"
  export TARGET_SLAVE=slave01
fi

echo "###################"
echo "Documentation available at :"
echo "http://almtools/confluence/display/ENG/Jenkins+-+UAT"
echo "###################"
echo "Switch to python 2.7 and ansible 2.1.1"
#scl enable python27 bash
#Enable python 2.7 and switch to ansible 2.1.1
source /opt/rh/python27/enable
python --version
pip --version
ansible --version
VBoxManage --version
vagrant --version
echo "###################"
VBoxManage list extpacks
echo "List VMS"
VBoxManage list vms
echo "List running VMS"
VBoxManage list runningvms
echo "###################"
#echo "Power off slave VM"
#VBoxManage controlvm slave01 acpipowerbutton || true
#VBoxManage controlvm slave02 acpipowerbutton || true
#VBoxManage controlvm slave03 acpipowerbutton || true
#VBoxManage controlvm slave04 acpipowerbutton || true
#sleep 30
#VBoxManage controlvm slave01 poweroff || true
#VBoxManage controlvm slave02 poweroff || true
#VBoxManage controlvm slave03 poweroff || true
#VBoxManage controlvm slave04 poweroff || true
#echo "Delete slave VM"
#VBoxManage unregistervm slave01 --delete || true
#VBoxManage unregistervm slave02 --delete || true
#VBoxManage unregistervm slave03 --delete || true
#VBoxManage unregistervm slave04 --delete || true
#vagrant destroy slave01
#vagrant destroy slave02
#vagrant destroy slave03
#vagrant destroy slave04
echo "###################"
vagrant status
vagrant global-status
#vagrant global-status --prune
#vagrant up --debug
#vagrant box update
vagrant up ${TARGET_SLAVE} || true
#vagrant up || exit 1
#VBoxManage startvm slave01 --type headless
#VBoxManage startvm slave02 --type headless
#VBoxManage startvm slave03 --type headless
#VBoxManage startvm slave04 --type headless
#Vagrant stuck connection timeout retrying
#https://stackoverflow.com/questions/22575261/vagrant-stuck-connection-timeout-retrying
#VBoxManage controlvm ${TARGET_SLAVE} keyboardputscancode 1c
vagrant ssh-config ${TARGET_SLAVE}
echo "###################"
#echo "Add Jenkins slave UAT VM key to 10.21.22.69 jenkins user"
#ssh-keygen -f "/home/jenkins/.ssh/known_hosts" -R [10.21.22.69]:2251
echo "###################"
echo "Refresh and start Jenkins"

echo "Switch to python 2.7 and ansible 2.1.1"
#scl enable python27 bash
#Enable python 2.7 and switch to ansible 2.1.1
source /opt/rh/python27/enable
python --version
ansible --version

cd ${WORKSPACE}/Scripts/ansible/

# install roles
ansible-galaxy install -r requirements.yml -p ./roles/ --ignore-errors

sleep 30
export ANSIBLE_REMOTE_USER=vagrant
export ANSIBLE_PRIVATE_KEY_FILE=$HOME/.vagrant.d/insecure_private_key
ssh-add $ANSIBLE_PRIVATE_KEY_FILE
#ansible -m setup ${TARGET_SLAVE} -i staging --user=vagrant --private-key=~/.vagrant.d/insecure_private_key  -vvvv
ansible -m setup ${TARGET_SLAVE} -i staging --user=vagrant -vvvv
#vagrant ssh

# check syntax 
#ansible-playbook -i staging -c local -v  jenkins-slave.yml --limit ${TARGET_SLAVE} -vvvv --syntax-check

ansible-playbook jenkins-slave.yml -i staging --limit ${TARGET_SLAVE} -vvvv || exit 2
echo "Connecting to slave"
#vagrant ssh-config
#ssh -p 2251 vagrant@10.21.22.69 "echo \"DONE\""
