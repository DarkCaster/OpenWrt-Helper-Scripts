#!/bin/bash
#

set -e

#add mobile_broadband feed
echo "src-git mobile_broadband https://gitlab.freedesktop.org/mobile-broadband/mobile-broadband-openwrt.git" >> feeds.conf

cat feeds.conf.default >> feeds.conf
sed -i "s|src-git luci https://git.openwrt.org/project/luci.git;openwrt-18.06|src-link luci /tmp/luci-openwrt1806|g" feeds.conf

rm -rf /tmp/luci-openwrt1806
rm -rf /tmp/luci-proto-modemmanager
git clone -b openwrt-18.06 https://git.openwrt.org/project/luci.git /tmp/luci-openwrt1806
git clone https://bitbucket.org/mips171/luci-proto-modemmanager.git /tmp/luci-proto-modemmanager
mv /tmp/luci-proto-modemmanager/luci-proto-modemmanager /tmp/luci-openwrt1806/protocols/

./scripts/feeds update -a
./scripts/feeds install -a

./scripts/feeds update mobile_broadband
./scripts/feeds install -p mobile_broadband -a
