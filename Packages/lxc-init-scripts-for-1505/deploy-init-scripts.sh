#!/bin/bash
#

curdir="$PWD"

showusage () {
 echo "Usage: build.sh <router ip>"
}

check_error () {
if [ "$?" != "0" ]; then
	echo "Build ended with error !!!"
	cd "$curdir"
	exit 1
fi
}

ipaddr="$1"
test "z$ipaddr" = "z" && showusage && exit 200

main_script_dir="$( cd "$( dirname "$0" )" && pwd )"

rsync -vcrlHpEogDtW --chown=root:root --inplace "$main_script_dir/init-scripts"/ root@$ipaddr:/

