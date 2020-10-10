#!/bin/bash
#

# packages to uninstall for openwrt 19.07 in order to fix broken stuff

exit 0

# all stuff seems to be fixed now

# usage: ./scripts/feeds uninstall <package name>

./scripts/feeds uninstall nfs-kernel-server # menuconfig tmp/.config-package.in:55375:error: recursive dependency detected!
./scripts/feeds uninstall samba4 # depends on nfs-kernel-server
./scripts/feeds uninstall luci-app-samba4 # depends on samba4

./scripts/feeds uninstall seafile-seahub # has a dependency on 'django-simple-captcha', which does not exist
./scripts/feeds uninstall seafile-server # depends on seafile-seahub
