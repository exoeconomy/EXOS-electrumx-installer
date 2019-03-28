#!/bin/sh

cd /tmp/exos-electrumx-installer/exos-electrumx-installer

if [ -e "./test/preinstall/$IMAGE" ]; then
    "./test/preinstall/$IMAGE"
fi

./install.sh
electrumx_server

