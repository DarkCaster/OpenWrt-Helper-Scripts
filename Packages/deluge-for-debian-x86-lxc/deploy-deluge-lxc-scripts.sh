#!/bin/bash
#

curdir="$PWD"

showusage () {
 echo "Usage: deploy.sh <router ip> [port]"
}

check_error () {
if [ "$?" != "0" ]; then
	echo "deploy ended with error !!!"
	cd "$curdir"
	exit 1
fi
}

ipaddr="$1"
test "z$ipaddr" = "z" && showusage && exit 200

port="$2"
test "z$port" = "z" && port="22444"

main_script_dir="$( cd "$( dirname "$0" )" && pwd )"

rsync -vcrlHpEogDtW --chown=root:root --inplace -e "ssh -p $port" "$main_script_dir/deluge-lxc-start-script"/ root@$ipaddr:/

