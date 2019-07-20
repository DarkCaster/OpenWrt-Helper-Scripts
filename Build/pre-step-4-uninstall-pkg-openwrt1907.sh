#!/bin/bash
#

# packages to uninstall for openwrt 19.07 in order to fix broken stuff

./scripts/feeds uninstall nfs-kernel-server # menuconfig tmp/.config-package.in:55375:error: recursive dependency detected!
./scripts/feeds uninstall samba4 # depends on nfs-kernel-server
./scripts/feeds uninstall luci-app-samba4 # depends on samba4
