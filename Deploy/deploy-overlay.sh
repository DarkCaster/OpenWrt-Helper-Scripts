#!/bin/bash

showusage () {
 echo "Usage: deploy-config.sh <router ip> <overlay-backup-dir> [target-dir-on-router]"
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

cfgdir="$2"
test "z$cfgdir" = "z" && showusage && exit 2

if [ ! -d "$cfgdir" ]; then
 script_dir="$( cd "$( dirname "$0" )" && pwd )"
 cfgdir="$script_dir/$cfgdir"
fi

test ! -d "$cfgdir" && echo "$cfgdir directory is missing" && exit 1

tgtdir="$3"

rsync -vcrlHpEogDtW --chown=root:root --inplace "$cfgdir"/ root@$ipaddr:"$tgtdir"/
check_error

