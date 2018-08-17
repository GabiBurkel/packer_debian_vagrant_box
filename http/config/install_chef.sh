#!/bin/bash


# install chef 
cd /tmp
wget https://packages.chef.io/files/current/chef/14.4.18/debian/9/chef_14.4.18-1_amd64.deb 
dpkg -i chef_14.4.18-1_amd64.deb

exit 0 
