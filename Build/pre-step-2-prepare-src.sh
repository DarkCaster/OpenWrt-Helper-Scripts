#!/bin/bash
#

# see README.md for more info

script_dir="$( cd "$( dirname "$0" )" && pwd )"

./scripts/feeds update -a
./scripts/feeds install -a

test -d "$script_dir/dl" && rsync -vrlHpEAXogDtSW --numeric-ids --delete-before "$script_dir/dl" .

rm -v .config .config.old
