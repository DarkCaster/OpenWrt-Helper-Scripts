#!/bin/bash

# packages to uninstall for gcc7 (ported from upstream) on LEDE 17.01

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

# fails on gcc 6.x and gcc 7.x
./scripts/feeds uninstall bonniexx # some stdlib macros was updated and incompatible now
./scripts/feeds uninstall gcc #native toolchain for run on target platform, using gcc 5.4 - failing to build with gcc 6.x cross-toolchain
./scripts/feeds uninstall haveged #Error: operand value out of range for instruction
./scripts/feeds uninstall linknx  # error: 'suncalc::std::abs' has not been declared

#fails on gcc 7.x
./scripts/feeds uninstall rtl-sdr #link error: rtl_power.c:(.text+0xc16): undefined reference to `FIX_MPY'
./scripts/feeds uninstall luci-app-dump1090 # depends on rtl-sdr
./scripts/feeds uninstall dump1090 # depends on rtl-sdr
./scripts/feeds uninstall addrwatch #storage.c:(.text+0xdc): undefined reference to `pkt_hash'
./scripts/feeds uninstall aircrack-ng #aircrack-ng.c:(.text+0x579e): undefined reference to `wpa_send_passphrase'
./scripts/feeds uninstall bandwidthd # bandwidthd.c:(.text+0xd54): undefined reference to `FindIp'; bandwidthd.c:(.text+0xd60): undefined reference to `Credit'
./scripts/feeds uninstall bwm-ng # process.c:(.text+0x488): undefined reference to `save_avg_values'
./scripts/feeds uninstall cmdpad # parse.c:(.text+0x1c): undefined reference to `rtrim'
./scripts/feeds uninstall lcd4linux # drv_G15.c:(.text+0x1c8): undefined reference to `drv_G15_evalScanCode'
./scripts/feeds uninstall netdata #web_client.c:(.text+0x37ba): undefined reference to `web_client_crock_socket'
./scripts/feeds uninstall oath-toolkit # intprops.h:234:34: error: expected ')' before '(' token
./scripts/feeds uninstall usbip # kernel build flags, need to remove -werror and others
