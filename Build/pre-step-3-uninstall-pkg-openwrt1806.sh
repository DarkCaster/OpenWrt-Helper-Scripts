#!/bin/bash
#

# additional packages to uninstall for openwrt 18.06, using gcc6

# this packages removed to fix broken dependencies
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
./scripts/feeds uninstall luci-mod-freifunk-community
./scripts/feeds uninstall node-mozilla-iot-gateway
./scripts/feeds uninstall prometheus-node-exporter-lua

# seems incompatible with gcc 6
./scripts/feeds uninstall addrwatch
./scripts/feeds uninstall bonnie++
./scripts/feeds uninstall clamsmtp
./scripts/feeds uninstall cmdpad
./scripts/feeds uninstall espeak # try to disable -Wnarrowing warning and retest
./scripts/feeds uninstall jool
./scripts/feeds uninstall kismet # needs uclibc
./scripts/feeds uninstall lcd4linux # undefined reference to `drv_G15_evalScanCode'
./scripts/feeds uninstall libartnet # -Werror=memset-elt-size
./scripts/feeds uninstall libsoup # Unescaped left brace in regex is illegal here in regex
./scripts/feeds uninstall mutt
./scripts/feeds uninstall nail
./scripts/feeds uninstall oath-toolkit
./scripts/feeds uninstall psqlodbc
./scripts/feeds uninstall quassel-irssi #-Werror=implicit-fallthrough=
./scripts/feeds uninstall rxtx # needs java (javac) for build
./scripts/feeds uninstall v4l2rtspserver # needs libasound.so.2
./scripts/feeds uninstall zmq #fatal error: basic_definitions: No such file or directory
./scripts/feeds uninstall pimbd
# ./scripts/feeds uninstall omcproxy # cannot be uninstalled ? disabled in config, instead

# does not build because of broken gstreamer1
./scripts/feeds uninstall gstreamer1
./scripts/feeds uninstall gnunet
./scripts/feeds uninstall gst1-plugins-ugly
./scripts/feeds uninstall gst1-plugins-good
./scripts/feeds uninstall gst1-plugins-base
./scripts/feeds uninstall gst1-plugins-bad
./scripts/feeds uninstall gnunet-secushare
./scripts/feeds uninstall gst1-libav
./scripts/feeds uninstall libextractor
./scripts/feeds uninstall libdmapsharing
./scripts/feeds uninstall dmapd

# other
./scripts/feeds uninstall autossh # ssh command not found ?
