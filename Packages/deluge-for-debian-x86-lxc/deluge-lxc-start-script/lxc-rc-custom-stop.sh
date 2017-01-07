#!/bin/sh

export PATH=/sbin:/usr/sbin:/bin:/usr/bin

NAME="deluge-web"
PIDFILE=/var/run/$NAME.pid

start-stop-daemon --stop --quiet --retry=TERM/10/KILL/5 --pidfile $PIDFILE
RETVAL="$?"
test "z$RETVAL" = "z0" && rm -f /var/log/deluged/deluge-web.log && rm -f $PIDFILE

NAME="deluged"
PIDFILE=/var/run/$NAME.pid

start-stop-daemon --stop --quiet --retry=TERM/10/KILL/5 --pidfile $PIDFILE
RETVAL="$?"
test "z$RETVAL" = "z0" && rm -f /var/log/deluged/deluged.log && rm -f $PIDFILE

