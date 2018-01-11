#!/bin/bash
#

# see README.md for more info

script_dir="$( cd "$( dirname "$0" )" && pwd )"

./scripts/feeds update -a
./scripts/feeds install -a

#recheck theese, now temporary disabled because of build bugs with my configuration:
####################################################################################

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
./scripts/feeds uninstall a51-flash

#build error
./scripts/feeds uninstall collectd

####################################################################################

#bloat software, that also cause build failures with my specific configuration
./scripts/feeds uninstall mosquitto
./scripts/feeds uninstall lua-mosquitto
./scripts/feeds uninstall zabbix-agent
./scripts/feeds uninstall openssh-client
./scripts/feeds uninstall luci-app-radicale
./scripts/feeds uninstall radicale-py2
./scripts/feeds uninstall freeswitch
./scripts/feeds uninstall kamailio3
./scripts/feeds uninstall kamailio4
./scripts/feeds uninstall libmicroxml
./scripts/feeds uninstall linknx
./scripts/feeds uninstall yunbridge

./scripts/feeds uninstall alfred
./scripts/feeds uninstall freecwmp
./scripts/feeds uninstall libfreecwmp
./scripts/feeds uninstall mailman
./scripts/feeds uninstall mktorrent
./scripts/feeds uninstall nmap
./scripts/feeds uninstall sstp-client
./scripts/feeds uninstall sshtunnel
./scripts/feeds uninstall dansguardian
./scripts/feeds uninstall e2guardian
./scripts/feeds uninstall crtmpserver
./scripts/feeds uninstall btrfs-progs
./scripts/feeds uninstall alpine
./scripts/feeds uninstall apache
./scripts/feeds uninstall aria2
./scripts/feeds uninstall tmux
./scripts/feeds uninstall kismet-server

./scripts/feeds uninstall batmand
./scripts/feeds uninstall batctl
./scripts/feeds uninstall f2fs-tools
./scripts/feeds uninstall hfsfsck

./scripts/feeds uninstall seafile-ccnet
./scripts/feeds uninstall seafile-seahub
./scripts/feeds uninstall seafile-server

./scripts/feeds uninstall squid
./scripts/feeds uninstall pthsem
./scripts/feeds uninstall redsocks
./scripts/feeds uninstall libupm
./scripts/feeds uninstall knxd
./scripts/feeds uninstall classpath
./scripts/feeds uninstall boost
./scripts/feeds uninstall libmraa
./scripts/feeds uninstall libpam
./scripts/feeds uninstall libzdb
./scripts/feeds uninstall libzmq-nc
./scripts/feeds uninstall lzmq
./scripts/feeds uninstall nut
./scripts/feeds uninstall pianod
./scripts/feeds uninstall screen
./scripts/feeds uninstall smartmontools
./scripts/feeds uninstall zile
./scripts/feeds uninstall restund
./scripts/feeds uninstall yate
./scripts/feeds uninstall libsearpc

./scripts/feeds uninstall simplejson
./scripts/feeds uninstall python3-bottle
./scripts/feeds uninstall python3
./scripts/feeds uninstall python-dns
./scripts/feeds uninstall python-imglib
./scripts/feeds uninstall python-mysql
./scripts/feeds uninstall python-pip
./scripts/feeds uninstall python-pyserial
./scripts/feeds uninstall python-setuptools
./scripts/feeds uninstall python-yaml
./scripts/feeds uninstall python
./scripts/feeds uninstall micropython-lib
./scripts/feeds uninstall micropython
./scripts/feeds uninstall node-arduino-firmata
./scripts/feeds uninstall node-cylon
./scripts/feeds uninstall node-hid
./scripts/feeds uninstall node-serialport
./scripts/feeds uninstall node
./scripts/feeds uninstall php5

./scripts/feeds uninstall erlang
./scripts/feeds uninstall jamvm
./scripts/feeds uninstall ruby

###material theme
#rsync -vrlHpEAXogDtSW --numeric-ids --delete-before ./../luci/themes/luci-theme-material ./feeds/luci/themes
#./scripts/feeds update -a
#./scripts/feeds install luci-theme-material

test -d "$script_dir/dl" && rsync -vrlHpEAXogDtSW --numeric-ids --delete-before "$script_dir/dl" .

rm -v .config .config.old

