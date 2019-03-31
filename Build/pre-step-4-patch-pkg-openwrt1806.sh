#!/bin/bash
#

set -e


# patch protobuf-c package
# see https://github.com/openwrt/packages/issues/6031 for more info

target_file="package/feeds/packages/protobuf-c/Makefile"

if [[ -f $target_file && -z `grep "HOST_BUILD_DEPENDS:=protobuf/host" $target_file` ]]; then
  echo "adding HOST_BUILD_DEPENDS:=protobuf/host to makefile $target_file"
  sed -i '/PKG_BUILD_DEPENDS:=protobuf-c\/host/a HOST_BUILD_DEPENDS:=protobuf\/host' $target_file
fi

# patch gammu packages

target_file="package/feeds/packages/gammu/Makefile"
echo "patching $target_file"
sed -i 's|/usr/lib$(LIB_SUFFIX)|/usr/lib|g' $target_file

# use automake 1.15.1 from trunk to fix build on Ubuntu 18.04
# see https://forum.openwrt.org/t/building-automake-in-current-master-fails-with-help2man-error/13405/4 for more info

echo "Downloading valid Makefile for automake-package"
pushd "package/feeds/packages/automake"
wget -O Makefile.new https://raw.githubusercontent.com/openwrt/packages/d7fefd2963d0ecf6c449e9fcfc72efb6b2786a65/devel/automake/Makefile
mv Makefile.new Makefile
popd

# libiio depends on zlib that may be not built when using parallel build

target_file="package/feeds/packages/libiio/Makefile"
echo "patching $target_file"
sed -i 's|DEPENDS:=\\|DEPENDS:= +zlib \\|g' $target_file

# darkstat depends on libbsd

target_file="package/feeds/packages/darkstat/Makefile"
echo "patching $target_file"
sed -i 's|DEPENDS:=+libpcap +zlib +USE_GLIBC:libbsd|DEPENDS:=+libbsd +libpcap +zlib +USE_GLIBC:libbsd|g' $target_file
