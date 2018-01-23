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

#fails on gcc 6.x
./scripts/feeds uninstall bonniexx # some stdlib macros was updated and incompatible now
./scripts/feeds uninstall gcc #native toolchain for run on target platform, using gcc 5.4 - failing to build with gcc 6.x cross-toolchain
./scripts/feeds uninstall haveged #Error: operand value out of range for instruction
#fails on gcc 6.x and gcc 7.x
./scripts/feeds uninstall linknx  # error: 'suncalc::std::abs' has not been declared
#fails on gcc 7.x
#./scripts/feeds uninstall rtl-sdr #link error: rtl_power.c:(.text+0xc16): undefined reference to `FIX_MPY'
#./scripts/feeds uninstall luci-app-dump1090 # depends on rtl-sdr
#./scripts/feeds uninstall dump1090 # depends on rtl-sdr
#./scripts/feeds uninstall addrwatch #storage.c:(.text+0xdc): undefined reference to `pkt_hash'
#./scripts/feeds uninstall aircrack-ng #aircrack-ng.c:(.text+0x579e): undefined reference to `wpa_send_passphrase'
#./scripts/feeds uninstall bandwidthd # bandwidthd.c:(.text+0xd54): undefined reference to `FindIp'; bandwidthd.c:(.text+0xd60): undefined reference to `Credit'
#./scripts/feeds uninstall bwm-ng # process.c:(.text+0x488): undefined reference to `save_avg_values'
#./scripts/feeds uninstall cmdpad # parse.c:(.text+0x1c): undefined reference to `rtrim'
#./scripts/feeds uninstall lcd4linux # drv_G15.c:(.text+0x1c8): undefined reference to `drv_G15_evalScanCode'
#./scripts/feeds uninstall netdata #web_client.c:(.text+0x37ba): undefined reference to `web_client_crock_socket'
#./scripts/feeds uninstall oath-toolkit # intprops.h:234:34: error: expected ')' before '(' token
#./scripts/feeds uninstall usbip # kernel build flags, need to remove -werror and others

# depends on libsrtp
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
./scripts/feeds uninstall opencv
./scripts/feeds uninstall znc
./scripts/feeds uninstall mcproxy
./scripts/feeds uninstall ndppd
./scripts/feeds uninstall sipp
./scripts/feeds uninstall softethervpn

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
