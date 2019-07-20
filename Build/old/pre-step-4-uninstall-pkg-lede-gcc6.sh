#!/bin/bash
#

# packages to uninstall for gcc6 on LEDE 17.01

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
./scripts/feeds uninstall netatalk # ???
