#!/bin/bash
#

set -e

script_dir="$( cd "$( dirname "$0" )" && pwd )"

# prepare custom feeds
echo "src-git mobile_broadband https://gitlab.freedesktop.org/mobile-broadband/mobile-broadband-openwrt.git" > feeds.conf
cat feeds.conf.default >> feeds.conf
sed -i "s|src-git luci https://git.openwrt.org/project/luci.git;openwrt-18.06|src-link luci ./luci-openwrt1806|g" feeds.conf

rm -rf ./luci-openwrt1806
rm -rf ./luci-proto-modemmanager
git clone -b openwrt-18.06 https://git.openwrt.org/project/luci.git ./luci-openwrt1806
git clone https://bitbucket.org/mips171/luci-proto-modemmanager.git ./luci-proto-modemmanager
mv ./luci-proto-modemmanager/luci-proto-modemmanager ./luci-openwrt1806/protocols/
rm -rf ./luci-proto-modemmanager

./scripts/feeds update -a
./scripts/feeds install -a

test -d "$script_dir/dl" && rsync -vrlHpEAXogDtSW --numeric-ids --delete-before "$script_dir/dl" .

rm -v .config .config.old
