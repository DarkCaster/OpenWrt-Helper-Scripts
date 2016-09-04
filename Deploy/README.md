# Helper scripts used for various deployment and service tasks

**USE AT YOUR OWN RISK!**

## backup-overlay.sh

Script that perform backup of overlay-fs from running openwrt router - only changed files relative to read-only firmware-root are backed up.
For use only with squash-fs + overlay-fs firmware configurations. You also need rsync to be installed on the router side.

