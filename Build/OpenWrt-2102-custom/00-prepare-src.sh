#!/bin/bash
#

set -e

script_dir="$( cd "$( dirname "$0" )" && pwd )"

# prepare custom feeds
cat feeds.conf.default > feeds.conf
echo "src-git custom https://github.com/DarkCaster/OpenWrt-Custom-Feed.git" >> feeds.conf

./scripts/feeds update -a
./scripts/feeds install -a

test -d "$script_dir/../dl" && rsync -qrlHpEAXogDtSW --numeric-ids --delete-before "$script_dir/../dl" .

rm -fv .config
rm -fv .config.old
