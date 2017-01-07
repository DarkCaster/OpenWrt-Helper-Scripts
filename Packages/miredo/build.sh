#!/bin/bash

curdir="$PWD"

showusage () {
 echo "Usage: build.sh <openwrt-sdk-bzip-archive>"
}

check_error () {
if [ "$?" != "0" ]; then
	echo "Build ended with error !!!"
	cd "$curdir"
	exit 1
fi
}

sdk="$1"
test ! -f "$sdk" && showusage && exit 200

main_script_dir="$( cd "$( dirname "$0" )" && pwd )"

# cleanup
rm -rf "$main_script_dir"/bin
check_error

builddir="`mktemp -d -t openwrt-build-XXXXXX`"
#builddir=""

# cd to builddir
cd "$builddir"
check_error

# extract sdk
bunzip2 -d -c "$sdk" | tar xf -
check_error

# cd to sdk
cd ./*
check_error

# patch sdk
patch -p2 -i "$main_script_dir/SDK-ccache-disable.patch"
check_error

# install miredo prkbuild
cp -r "$main_script_dir/miredo" ./package/miredo
check_error

# copy miredo source
mkdir -p ./dl
check_error

cp "$main_script_dir"/miredo-1.2.6.git.2014.08.13-*.tar.bz2 ./dl/
check_error

# prepare env
. "$main_script_dir/prepare-env.sh"
check_error

# build
make -j1 V=s
check_error

# copy result
mkdir -p "$main_script_dir"/bin/miredo_packages
check_error

cp -r ./bin/*/packages/base/* "$main_script_dir"/bin/miredo_packages/
check_error

# go back
cd "$curdir"

# cleanup
rm -rf "$builddir"
check_error

exit 0

