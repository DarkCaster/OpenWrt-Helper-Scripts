#!/bin/bash
#

# see README.md for more info

script_dir="$( cd "$( dirname "$0" )" && pwd )"

./scripts/feeds update -a
./scripts/feeds install -a

#fail after this commit: https://github.com/openwrt/packages/commit/400d01d37f5243308a4692b8c2a8b42cb6df23a1
./scripts/feeds uninstall tor

#looks like, it fail after gnutls update to newer version, recheck
./scripts/feeds uninstall wifidog

#currently fails on x86
./scripts/feeds uninstall krb5-libs

#error accessing repo
./scripts/feeds uninstall olsrd
./scripts/feeds uninstall oonf-olsrd2
./scripts/feeds uninstall oonf-dlep-proxy
./scripts/feeds uninstall oonf-dlep-radio
./scripts/feeds uninstall oonf-init-scripts

#git repo is unavailable
./scripts/feeds uninstall ap51-flash

#requres libuClibc++
./scripts/feeds uninstall smartmontools

#build error
./scripts/feeds uninstall collectd
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
./scripts/feeds uninstall softethervpn
./scripts/feeds uninstall opencv
./scripts/feeds uninstall znc
./scripts/feeds uninstall mcproxy
./scripts/feeds uninstall ndppd
./scripts/feeds uninstall sipp

# pam headers missing ?
./scripts/feeds uninstall openssh-client
./scripts/feeds uninstall sshtunnel

# disabled beacause of failing luasocket: https://github.com/openwrt/packages/issues/3590
./scripts/feeds uninstall luarocks
./scripts/feeds uninstall prosody
./scripts/feeds uninstall luasoap
./scripts/feeds uninstall luasec
./scripts/feeds uninstall uuid
./scripts/feeds uninstall json4lua
./scripts/feeds uninstall luci-app-cjdns
./scripts/feeds uninstall cjdns
./scripts/feeds uninstall luasocket

# disabled because of failed libwebsockets
./scripts/feeds uninstall ttyd
./scripts/feeds uninstall mosquitto
./scripts/feeds uninstall lua-mosquitto
./scripts/feeds uninstall vallumd
./scripts/feeds uninstall libwebsockets

#bloat software, that also cause build failures with my specific configuration
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
./scripts/feeds uninstall batctl

./scripts/feeds uninstall redsocks
./scripts/feeds uninstall libupm
./scripts/feeds uninstall knxd
./scripts/feeds uninstall classpath
./scripts/feeds uninstall libmraa
./scripts/feeds uninstall libpam

./scripts/feeds uninstall libzmq-nc
./scripts/feeds uninstall lzmq
./scripts/feeds uninstall nut
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

###material theme
#rsync -vrlHpEAXogDtSW --numeric-ids --delete-before ./../luci/themes/luci-theme-material ./feeds/luci/themes
#./scripts/feeds update -a
#./scripts/feeds install luci-theme-material

test -d "$script_dir/dl" && rsync -vrlHpEAXogDtSW --numeric-ids --delete-before "$script_dir/dl" .

rm -v .config .config.old

