#!/bin/bash
#

set -e

_build_sh_dir="$(cd "$(dirname "$0")" && pwd)"

usage() {
  echo "usage: build.sh <openwrt-version> <diffconfig-file>"
  echo "you must run this script from the base of openwrt directory"
  exit 2
}

_openwrt_ver="$1"
_diff_config="$2"

[[ -z $_openwrt_ver || -z $_diff_config ]] && usage
[[ ! -d "$_build_sh_dir/$_openwrt_ver" ]] && echo "directory missing: $_build_sh_dir/$_openwrt_ver, cannot continue!" && usage

_jobs_count=$(nproc 2>/dev/null)
[[ -z $_jobs_count ]] && _jobs_count="2"
echo "auto-detected jobs count: $_jobs_count"

echo "running: git clean -dfx --force"
git clean -dfx --force

echo "env cleanup"
. "$_build_sh_dir/clean-env.sh.in"

echo "running preparation scripts"
while read script; do
  echo "running: $script"
  "$script"
done < <(find "$_build_sh_dir/$_openwrt_ver" -type f -name "*.sh" | sort)

echo "installing config from $_diff_config"
cp "$_diff_config" .config
make defconfig
./scripts/diffconfig.sh > test.diffconfig

echo "ensuring diffconfig is unchanged"
if ! diff 1>/dev/null "$_diff_config" "test.diffconfig"; then
    echo "error: diffconfig is changed:"
    diff -uprN "$_diff_config" "test.diffconfig"
fi
rm -v "test.diffconfig"

echo "downloading missing sources"
make download

echo "making backup of downloaded sources"
"$_build_sh_dir/create-dl-backup.sh"

make world -j$_jobs_count
echo "build complete"

echo "making backup of downloaded sources (again)"
"$_build_sh_dir/create-dl-backup.sh"
