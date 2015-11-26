#!/usr/bin/env bash

prefix=/var/lib/glusterfs
mkdir -p $prefix || exit 1
if [ $# -eq 1 ]; then 
    if [ "$1" = "check" ]; then
        libpkgs="libsqlite3-0 liburcu1 libibverbs1 libssl1.0.0 libxml2 libaio1 libacl1 libcmocka0"
        libpkgs="$libpkgs librdmacm1"
        libpkgs="$libpkgs sqlite3 uuid python-simplejson python-ctypeslib libreadline6"

        pkgs="flex bison make automake libtool pkg-config"
        pkgs="$pkgs libsqlite3-dev python-dev liburcu-dev libibverbs-dev libreadline-dev"
        pkgs="$pkgs libssl-dev libxml2-dev libaio-dev libacl1-dev uuid-dev libcmocka-dev"
        pkgs="$pkgs librdmacm-dev"
        pkgs="$libpkgs $pkgs"
        sudo apt-get install -y $pkgs || exit 1
    else
        exit 0
    fi
fi

rootfs="$prefix/rootfs"
subdirs="sbin lib/systemd/system etc/init.d"
for item in $subdirs; do
    mkdir -p $rootfs/$item
done
pydir=$(python -c 'from distutils.sysconfig import get_python_lib; print(get_python_lib())')
mkdir -p $rootfs/$pydir

opts="--prefix=$prefix"
opts="$opts --with-pythondir=$rootfs/$pydir"
opts="$opts --with-mountutildir=$rootfs/sbin"
opts="$opts --with-systemddir=$rootfs/lib/systemd/system"
opts="$opts --with-initdir=$rootfs/etc/init.d"
./configure $opts


#
# For configure.ac
#+AC_ARG_WITH(pythondir,
#+            [  --with-pythondir=DIR python lib files in DIR @<:@auto@:>@],
#+            [pythondir=$withval],
#+            [pythondir='auto'])
#+AC_SUBST(pythondir)
#-   BUILD_PYTHON_SITE_PACKAGES=`$PYTHON -c 'from distutils.sysconfig import get_python_lib; print(get_python_lib())'`
#+   if test "x$pythondir" = "xauto"; then
#+      BUILD_PYTHON_SITE_PACKAGES=`$PYTHON -c 'from distutils.sysconfig import get_python_lib; print(get_python_lib())'`
#+   else
#+      BUILD_PYTHON_SITE_PACKAGES=$pythondir
#+   fi

