#!/bin/bash
#

# see README.md for more info

script_dir="$( cd "$( dirname "$0" )" && pwd )"

test -d ./dl || exit 1

echo "making backup of ./dl folder"

test -d "$script_dir/dl" || mkdir -v "$script_dir/dl"

rsync -vcrlHpEAXogDtSW --numeric-ids --delete-before ./dl/ "$script_dir/dl"

