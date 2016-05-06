#!/usr/bin/env bash

if [ $# -eq 1 ]; then 
    if [ "$1" = "check" ]; then
        pkgs="libsqlite3-0 liburcu1 libibverbs1 libssl1.0.0 libxml2 libaio1 libacl1 libcmocka0 librdmacm1"
        pkgs="$pkgs sqlite3 uuid python-simplejson python-ctypeslib libreadline6"
        sudo apt-get install -y $libpkgs || exit 1

        pkgs="flex bison make automake autoconf libtool pkg-config"
        sudo apt-get install -y $pkgs || exit 1

        pkgs="libsqlite3-dev python-dev liburcu-dev libibverbs-dev libreadline-dev"
        pkgs="$pkgs libssl-dev libxml2-dev libaio-dev libacl1-dev uuid-dev libcmocka-dev"
        pkgs="$pkgs librdmacm-dev"
        pkgs="$libpkgs $pkgs"
        sudo apt-get install -y $pkgs || exit 1
    else
        exit 0
    fi
fi

[ ! -f ./configure ] && sh autogetn.sh

./configure
