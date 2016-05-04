#!/usr/bin/env bash

if [ $# -eq 1 ]; then 
    if [ "$1" = "check" ]; then
        libpkgs="make automake autoconf libtool"
        sudo apt-get install -y $pkgs || exit 1

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

[ ! -f ./configure ] && sh autogetn.sh

opts="--prefix=/usr"
./configure $opts
