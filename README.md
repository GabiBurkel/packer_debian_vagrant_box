# build_debian_vagrant_box

Build a debian vagrant box with chef client installed so that it is testkitchen ready. 

Check and/change the debian9.json file to according to your requirements. 

Then run: ./build_vagrant_box_now.sh


... wait and watch your vagrant box being built .. 



Fire up and logon to your new box like so: 

* vagrant box add --name kitchen-debian-9.5_chef14-4-18 ./kitchen-debian-9.5_chef14-4-18.box

* vagrant init kitchen-debian-9.5_chef14-4-18

* vagrant up (this will show ssh authentication errors. The process can be interupted at this point. The VM will remain running.)

* logon like so: ssh vagrant@localhost -p 2222 (password: vagrant)


What to do with vagrant VM? 

* list all running vms: vboxmanage list runningvms
* show status with vagrant: vagrant status
* halt VM: vagrant halt
* destroy box: vagrant destroy <machine-name>
* remove box: vagrant box remove <box-name> 


Known issues: 
* there is no working ssh - key involved in this setup. Therefore make sure to use password authentication in kitchen. 
Configure it like so: 

driver:
  name: vagrant
  ssh:
      insert_key: true
      username: 'vagrant'
      password: 'vagrant'

