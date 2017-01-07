#!/bin/sh

export PATH=/sbin:/usr/sbin:/bin:/usr/bin

#check shared directory status
test ! -f /mnt/external/mount.check && exit 0

#check read\write
if [ -f /mnt/external/mount.test ]; then
 rm /mnt/external/mount.test
 test "z$?" != "z0" && exit 0
fi

touch /mnt/external/mount.test
test "z$?" != "z0" && exit 0

test ! -f /mnt/external/mount.test && exit 0

rm /mnt/external/mount.test
test "z$?" != "z0" && exit 0

#change blocklist config, if present
if [ -f "/var/lib/deluged/config/blocklist.conf" ]; then
 sed -i 's|"check_after_days": 4|"check_after_days": 1|g' "/var/lib/deluged/config/blocklist.conf"
 sed -i 's|"load_on_start": false|"load_on_start": true|g' "/var/lib/deluged/config/blocklist.conf"
fi

USER=debian-deluged
MASK=0027

NAME="deluged"
DAEMON=/usr/bin/$NAME
DAEMON_ARGS="-d -c /var/lib/deluged/config -l /var/log/deluged/deluged.log -L info"
PIDFILE=/var/run/$NAME.pid

start-stop-daemon --start --background --quiet --pidfile $PIDFILE --exec $DAEMON --chuid $USER --umask $MASK --test > /dev/null || exit 1
start-stop-daemon --start --background --quiet --pidfile $PIDFILE --make-pidfile --exec $DAEMON --chuid $USER --umask $MASK -- $DAEMON_ARGS || exit 2

NAME="deluge-web"
DAEMON=/usr/bin/$NAME
DAEMON_ARGS="-p 22555 --no-ssl -c /var/lib/deluged/config -l /var/log/deluged/deluge-web.log -L info"
PIDFILE=/var/run/$NAME.pid

start-stop-daemon --start --background --quiet --pidfile $PIDFILE --exec $DAEMON --chuid $USER --umask $MASK --test > /dev/null || exit 1
start-stop-daemon --start --background --quiet --pidfile $PIDFILE --make-pidfile --exec $DAEMON --chuid $USER --umask $MASK -- $DAEMON_ARGS || exit 2

