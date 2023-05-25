#!/bin/bash
#

set -e

script_dir="$( cd "$( dirname "$0" )" && pwd )"

#apply patches

find "$script_dir" -type f -name "fix-*.patch" -print0 | sort -z | while read -d $'\0' file
do
  echo "Applying patch: $file"
  patch -p1 -i "$file"
done
