#!/bin/bash
#

name="miredo"
url="http://git.remlab.net/git/miredo.git"
checkout="6eb5e5a417667d47dfca31f80d5f3debbc4c4e0e"
version="1.2.6.git.2014.08.13"
name="$name-$version-$checkout"

script_dir="$( cd "$( dirname "$0" )" && pwd )"

olddir="$PWD"

check_errors () {
 local status="$?"
 if [ "$status" != "0" ]; then
  echo "ERROR: script failed!"
  exit 1
 fi
}

cd "$script_dir"
check_errors

git clone "$url" "$name"
check_errors

cd $name
check_errors

if [ "$checkout" != "master" ]; then
 git checkout "$checkout"
 check_errors
fi

git submodule update --init
check_errors

rm -rf .git
check_errors

rm -f .gitattributes
check_errors

rm -f .gitignore
check_errors

rm -f .gitmodules
check_errors

cd ..
check_errors

tar cf "$name.tar" "$name" --owner=0 --group=0
check_errors

bzip2 -9 "$name.tar"
check_errors

rm -rf "$name"
check_errors

cd "$olddir"
check_errors

