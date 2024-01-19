#!/bin/bash

showusage () {
 echo "Usage: deploy-config.sh <router ip> <port> <overlay-backup-dir> [target-dir-on-router]"
}

check_error () {
local ec="$?"
if [ "$ec" != "0" ]; then
 echo "last command completed with error!"
 exit $ec
fi
}

ipaddr="$1"
test "z$ipaddr" = "z" && showusage && exit 3

port="$2"
test "z$port" = "z" && showusage && exit 3

cfgdir="$3"
test "z$cfgdir" = "z" && showusage && exit 2

if [ ! -d "$cfgdir" ]; then
 script_dir="$( cd "$( dirname "$0" )" && pwd )"
 cfgdir="$script_dir/overlay-backups/$cfgdir"
fi

test ! -d "$cfgdir" && echo "$cfgdir directory is missing" && exit 1

tgtdir="$4"

rsync -vcrlHpEogDtW -e 'ssh -p '$port'' --chown=root:root --inplace "$cfgdir"/ root@$ipaddr:"$tgtdir"/
check_error

