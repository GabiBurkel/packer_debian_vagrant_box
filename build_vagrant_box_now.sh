#!/bin/bash

set -ex


# usually eth0 or ens33 but could be anything 
HOST_NW_INTERFACE=ens33

# enable for debugging purposes
# export PACKER_LOG_PATH="/tmp/packer.log"
# export PACKER_LOG=1
# DEBUG_FLAG=-debug
# ON_ERROR_FLAG=ask

packer validate debian9.json


ip_address=`ip addr show $HOST_NW_INTERFACE | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*'`

preseed_url="preseed/url=http://$ip_address:8080/config/preseed.cfg"

# start temporary webserver
cd http

prev_pid=$(ps -ef | grep -E 'python -m SimpleHTTPServer 8080' | grep -v 'grep' | awk '{print $2}')
if [ ! -z "$prev_pid" ];
  then
    echo "killing previous webserver with pid $prev_pid"
    kill -15 $prev_pid
fi

$(nohup python -m SimpleHTTPServer 8080 &>/dev/null &)
cd ..


packer build $DEBUG_FLAG $ON_ERROR_FLAG -force -var "preseed_url=$preseed_url" debian9.json | tee build.log


# kill temporary webserver
webserver_pid=$(ps -ef | grep -E 'python -m SimpleHTTPServer 8080' | grep -v 'grep' | awk '{print $2}')
if [ ! -z "$webserver_pid" ];
  then
    echo "Killing webserver with PID: $webserver_pid"
    kill -15 $webserver_pid
fi

exit 0 
