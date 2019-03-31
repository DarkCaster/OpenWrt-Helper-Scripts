#!/bin/bash
#

# packages to uninstall for openwrt 15.05 and older

# old packages
./scripts/feeds uninstall collectd
./scripts/feeds uninstall libwebsockets
./scripts/feeds uninstall mosquitto
./scripts/feeds uninstall nut
./scripts/feeds uninstall lua-mosquitto
./scripts/feeds uninstall softethervpn

./scripts/feeds uninstall ndppd
./scripts/feeds uninstall mcproxy
./scripts/feeds uninstall krb5-libs
./scripts/feeds uninstall luci-app-cjdns
./scripts/feeds uninstall cjdns
./scripts/feeds uninstall luasocket
