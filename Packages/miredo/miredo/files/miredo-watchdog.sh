#!/bin/sh

log () {
 local msg="$@"
 logger -t miredo-watchdog.sh "$msg"
 true
}

do_exit () {
 local code="$1"
 log "exiting with code $code"
 exit $code
}

showusage () {
 echo "Usage: miredo-watchdog.sh <config>"
 do_exit 1
}

check_error () {
 local ec="$?"
 test "z$ec" != "z0" && log "last operation failed with error code: $ec" && do_exit 2
}

check_miredo_is_running() {
 local psw="`ps -w`"
 local check=`echo "$psw" | grep "/usr/sbin/miredo " | wc -l`
 test "z$check" = "z0" && echo "false" || echo "true"
}

get_wan_ipaddr() {
 local iface="$1"
 local ec="1"

 #check interface is up
 ip link show $iface 2>/dev/null 1>&2
 ec="$?"
 test "z$ec" != "z0" && echo "0" && return

 #get ip address
 local ip=`2>/dev/null ip addr list $iface | grep -m 1 "inet " | cut -d' ' -f6 | cut -d/ -f1`
 test "z$ip" = "z" && echo "0" && return

 echo "$ip"
}

get_teredo_ipaddr() {
 local iface="$1"
 local ip=`2>/dev/null ip addr list $iface | grep "inet6 " | grep -m 1 "global" | cut -d' ' -f6 | cut -d/ -f1`
 test "z$ip" = "z" && echo "0" && return
 echo "$ip"
}

config="$1"

test ! -f "$config" && showusage

test "`check_miredo_is_running`" = "true" && log "miredo already running. cannot proceed" && do_exit 3

log "loading miredo watchdog config"

# load config
. $config
check_error

test "z$wanif" = "z" && log "wan inteface variable wanif not defined in config" && do_exit 2
test "z$server" = "z" && log "server variable not defined in config" && do_exit 1

log "starting miredo watchdog"

while true; do
 #detect ip address
 wanip=`get_wan_ipaddr $wanif`
 #if no ip - sleep; restart loop
 test "z$wanip" = "z0" && sleep 5 && continue
 #verify that wan is working, test ping to google; sleep and restart loop if failed
 2>/dev/null 1>&2 ping -4 -c 1 google.com -w 5
 test "z$?" != "z0" && sleep 5 && continue
 log "ipv4 connectivity is working"
 #wait 5 more seconds as additional safety measure
 sleep 5
 #generate config
 log "generating miredo config for wan interface $wanif with ip $wanip"
 mkdir -p /tmp/etc
 echo "RelayType client" > /tmp/etc/miredo.conf
 echo "InterfaceName teredo" >> /tmp/etc/miredo.conf
 echo "BindAddress $wanip" >> /tmp/etc/miredo.conf
 echo "ServerAddress $server" >> /tmp/etc/miredo.conf
 #run miredo; sleep;
 log "starting new miredo client instance"
 /usr/sbin/miredo -c /tmp/etc/miredo.conf
 sleep 5
 ip6wait="32"
 #wait while miredo is running, and wan is up
 while [ "`get_wan_ipaddr $wanif`" = "$wanip" ] && [ "`check_miredo_is_running`" = "true" ]; do
  #check teredo ip; fail if not found
  if [ "`get_teredo_ipaddr teredo`" = "0" ]; then
   test "$ip6wait" = "0" && log "ipv6 link was shutdown, restarting" && break
   #not found: decrement counter
   ip6wait=`expr $ip6wait - 1`
   test "$ip6wait" = "0" && log "timed out waiting for ipv6 connection, restarting" && break
   log "awaiting for ipv6 connection is properly established: $ip6wait tries left"
  else
   #found global ipv6 addr
   if [ "$ip6wait" != "0" ]; then
    log "checking ipv6 connectivity"
    #check connectivity, fail if no
    2>/dev/null 1>&2 ping -6 -c 1 ipv6.google.com -w 5
    test "z$?" != "z0" && log "ipv6 connectivity is not working, restarting" && break
    #reset ip6wait var
    ip6wait="0"
    log "ipv6 connectivity is working"
   fi
  fi
  sleep 5
 done
 #terminate miredo client
 if [ "`check_miredo_is_running`" = "true" ]; then
  log "terminating miredo client instance"
  2>/dev/null killall -TERM miredo
  test "`check_miredo_is_running`" = "true" && sleep 3
  test "`check_miredo_is_running`" = "true" && log "killing miredo client instance" && 2>/dev/null killall -KILL miredo
  test "`check_miredo_is_running`" = "true" && sleep 3
  test "`check_miredo_is_running`" = "true" && log "miredo client was NOT terminated" && do_exit 50
 fi
 log "attempting to restart miredo"
done

log "abnormal exit"
do_exit 100

