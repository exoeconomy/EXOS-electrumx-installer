#!/bin/sh

cd /tmp/electrumx-civx-installer/electrumx-civx-installer

if [ -e "./test/preinstall/$IMAGE" ]; then
    "./test/preinstall/$IMAGE"
fi

./install.sh
electrumx_server

