#!/bin/bash
#

# fail after this commit: https://github.com/openwrt/packages/commit/400d01d37f5243308a4692b8c2a8b42cb6df23a1
./scripts/feeds uninstall tor
./scripts/feeds uninstall torsocks

#looks like, it fail after gnutls update to newer version, recheck
./scripts/feeds uninstall wifidog

# depends on libsrtp, also some of this packages faling too with some configurations
./scripts/feeds uninstall asterisk13
./scripts/feeds uninstall asterisk11-chan-dongle
./scripts/feeds uninstall asterisk11
./scripts/feeds uninstall asterisk11-codec-g729
./scripts/feeds uninstall libpjsua2
./scripts/feeds uninstall libsrtp # datatypes.c:(.text+0x11e): undefined reference to `hex_char_to_nibble'

#error accessing repo
./scripts/feeds uninstall olsrd
./scripts/feeds uninstall oonf-olsrd2
./scripts/feeds uninstall oonf-dlep-proxy
./scripts/feeds uninstall oonf-dlep-radio
./scripts/feeds uninstall oonf-init-scripts

#git repo is unavailable
./scripts/feeds uninstall ap51-flash

#build error
./scripts/feeds uninstall elektra-kdb
./scripts/feeds uninstall freeradius2
./scripts/feeds uninstall gpsd
./scripts/feeds uninstall grilo
./scripts/feeds uninstall grilo-plugins
./scripts/feeds uninstall lcdgrilo
./scripts/feeds uninstall hamlib
./scripts/feeds uninstall horst
./scripts/feeds uninstall iotivity
./scripts/feeds uninstall loudmouth
./scripts/feeds uninstall rtl-ais
./scripts/feeds uninstall opencv
./scripts/feeds uninstall znc
./scripts/feeds uninstall sipp

# disabled beacause of failing luasocket: https://github.com/openwrt/packages/issues/3590
./scripts/feeds uninstall luarocks
./scripts/feeds uninstall prosody
./scripts/feeds uninstall luasoap
./scripts/feeds uninstall luasec
./scripts/feeds uninstall uuid
./scripts/feeds uninstall json4lua

# disabled because of failed libwebsockets
./scripts/feeds uninstall ttyd
./scripts/feeds uninstall vallumd

# bloat software, several packages also cause build failures with some of my specific configurations
./scripts/feeds uninstall luci-app-radicale
./scripts/feeds uninstall radicale-py2
./scripts/feeds uninstall freeswitch
./scripts/feeds uninstall kamailio4
./scripts/feeds uninstall yunbridge

./scripts/feeds uninstall alfred
./scripts/feeds uninstall dansguardian
./scripts/feeds uninstall e2guardian
./scripts/feeds uninstall crtmpserver
./scripts/feeds uninstall alpine
./scripts/feeds uninstall apache
./scripts/feeds uninstall kismet-server
./scripts/feeds uninstall batmand
./scripts/feeds uninstall batman-adv
./scripts/feeds uninstall batctl

./scripts/feeds uninstall redsocks
./scripts/feeds uninstall libupm
./scripts/feeds uninstall knxd
./scripts/feeds uninstall classpath
./scripts/feeds uninstall libmraa

./scripts/feeds uninstall libzmq-nc
./scripts/feeds uninstall lzmq

./scripts/feeds uninstall pianod
./scripts/feeds uninstall zile
./scripts/feeds uninstall restund
./scripts/feeds uninstall yate

./scripts/feeds uninstall node-arduino-firmata
./scripts/feeds uninstall node-cylon
./scripts/feeds uninstall node-hid
./scripts/feeds uninstall node-serialport
./scripts/feeds uninstall node

./scripts/feeds uninstall erlang
./scripts/feeds uninstall jamvm
./scripts/feeds uninstall ruby
