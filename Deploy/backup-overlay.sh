#!/bin/bash

showusage () {
 echo "Usage: backup-overlay.sh <router ip> [config dir base /overlay/upper by default]"
}

check_error () {
local ec="$?"
if [ "$ec" != "0" ]; then
 echo "last command completed with error!"
 exit $ec
fi
}

ipaddr="$1"
test "z$ipaddr" = "z" && showusage && exit 1

cfgdir="$2"
test "z$cfgdir" = "z" && cfgdir="/overlay/upper"

date=`date +%Y-%m-%d+%H-%M-%S`

script_dir="$( cd "$( dirname "$0" )" && pwd )"

dest="$script_dir/overlay-backups"

test -L "$dest" && dest=`readlink -f "$dest"`

if [ ! -d "$dest" ]; then
 mkdir "$dest"
 check_error
fi

rsync -vcrlHpEDtW --numeric-ids --inplace root@$ipaddr:"$cfgdir"/ "$script_dir/overlay-backups/backup-$date"/
check_error
