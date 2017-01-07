main_script_dir="$( cd "$( dirname "$0" )" && pwd )"

olddir="$PWD"

check_error () {
if [ "$?" != "0" ]; then
	echo "Build ended with error !!!"
	cd "$curdir"
	exit 1
fi
}

rm -rf "$main_script_dir/bin"
check_error

mkdir -p "$main_script_dir/bin"
check_error

rm -rf "$main_script_dir/build"
check_error

mkdir -p "$main_script_dir/build"
check_error

cp "$main_script_dir/sinit"/* "$main_script_dir/build"
check_error

cd "$main_script_dir/build"
check_error

CFLAGS="-m32" LDFLAGS="-m32" make
check_error

cp "$main_script_dir/build/sinit" "$main_script_dir/bin/sinit.x86"
check_error

cp "$main_script_dir/templates/"*-x86-* "$main_script_dir/bin"
check_error

rm -rf "$main_script_dir/build"
check_error

cd "$olddir"
check_error

