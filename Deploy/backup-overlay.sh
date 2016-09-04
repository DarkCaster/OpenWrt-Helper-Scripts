#!/bin/bash

showusage () {
 echo "Usage: backup-overlay.sh <router ip>"
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

date=`date +%Y-%m-%d+%H-%M-%S`

script_dir="$( cd "$( dirname "$0" )" && pwd )"

dest="$script_dir/overlay-backups"

test -L "$dest" && dest=`readlink -f "$dest"`

if [ ! -d "$dest" ]; then
 mkdir "$dest"
 check_error
fi

rsync -vcrlHpEDtW --numeric-ids --inplace root@$ipaddr:/overlay/upper/ "$script_dir/overlay-backups/backup-$date"/
check_error

