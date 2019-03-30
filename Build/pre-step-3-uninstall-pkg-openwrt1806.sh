#!/bin/bash
#

# additional packages to uninstall for openwrt 18.06

./scripts/feeds uninstall domoticz
./scripts/feeds uninstall freeswitch-stable
./scripts/feeds uninstall freeswitch-stable-mod-bcg729
./scripts/feeds uninstall freifunk-gwcheck
./scripts/feeds uninstall freifunk-mapupdate
./scripts/feeds uninstall kamailio-5.x
./scripts/feeds uninstall lcdringer
./scripts/feeds uninstall ldbus

./scripts/feeds uninstall luci-app-e2guardian
./scripts/feeds uninstall luci-app-olsr
./scripts/feeds uninstall luci-app-olsr-services
./scripts/feeds uninstall luci-app-olsr-viz
./scripts/feeds uninstall luci-app-statistics
./scripts/feeds uninstall luci-mod-freifunk-community
./scripts/feeds uninstall node-mozilla-iot-gateway
./scripts/feeds uninstall prometheus-node-exporter-lua
./scripts/feeds uninstall addrwatch
./scripts/feeds uninstall autossh
