#!/bin/bash

showusage () {
 echo "Usage: backup-with-sysupgrade <router ip>"
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

rsync -W --rsync-path='rm -f /tmp/cfgbak && sysupgrade -b /tmp/cfgbak && rsync' root@$ipaddr:"/tmp/cfgbak" "/tmp/cfgbak-$date.tar.gz"
check_error

mkdir "$script_dir/overlay-backups/backup-$date"
check_error

gunzip -c "/tmp/cfgbak-$date.tar.gz" | tar -C "$script_dir/overlay-backups/backup-$date" -xvf -
check_error

rm -f "/tmp/cfgbak-$date.tar.gz"
check_error
