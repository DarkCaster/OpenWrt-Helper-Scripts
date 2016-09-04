# Helper scripts used for build process

**USE AT YOUR OWN RISK!**

## pre-step-1-prepare-env.sh

Script should be sourced to environment ( e.g  ". pre-step-1-prepare-env.sh" ).
This script perform cleanup of env-variables before configure and build openwrt firmware.
For now it just remove all unnecessary variables from my particular env.
TODO: smart remove variables based on blacklist (or whitelist).

## pre-step-2-prepare-src.sh

This script should be started from build directory. It performs OpenWrt source tree preparation, feeds update and external packages configuration.

## post-step-create-dl-backup.sh

This script should be started from build directory after build is complete.
It will create (and update) backup of cache folder (./dl) that is populated with source-archives of packages downloaded during build.
At the time of next build this cache will be restored by pre-step-2-prepare-src.sh script,
and this will reduce build time and failure probability, especially if your internet connection is bad (as my english, haha).

