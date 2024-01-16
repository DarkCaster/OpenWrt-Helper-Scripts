#!/bin/bash
#

set -e

script_dir="$( cd "$( dirname "$0" )" && pwd )"

# prepare custom feeds
cat feeds.conf.default > feeds.conf
echo "src-git custom file://${script_dir}/../../../Custom-Feed" >> feeds.conf

sed -i -e 's|git.openwrt.org/feed|github.com/openwrt|g' feeds.conf
sed -i -e 's|git.openwrt.org/project/luci.git|github.com/openwrt/luci.git|g' feeds.conf

./scripts/feeds update -a
./scripts/feeds install -a

test -d "$script_dir/../dl" && rsync -qrlHpEAXogDtSW --numeric-ids --delete-before "$script_dir/../dl" .

rm -fv .config
rm -fv .config.old
