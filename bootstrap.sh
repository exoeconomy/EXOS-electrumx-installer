#!/bin/bash
if [ -d ~/.exos-electrumx-installer ]; then
    echo "~/.exos-electrumx-installer already exists."
    echo "Either delete the directory or run ~/.exos-electrumx-installer/install.sh directly."
    exit 1
fi
if which git > /dev/null 2>&1; then
    git clone https://github.com/exoeconomy/exos-electrumx-installer ~/.exos-electrumx-installer
else
    which wget > /dev/null 2>&1 && which unzip > /dev/null 2>&1 || { echo "Please install git or wget and unzip" && exit 1 ; }
    wget https://github.com/exoeconomy/exos-electrumx-installer/archive/master.zip -O /tmp/exos-electrumx-master.zip
    unzip /tmp/exos-electrumx-master.zip -d ~/.exos-electrumx-installer
    rm /tmp/exos-electrumx-master.zip
fi
cd ~/.exos-electrumx-installer/
if [[ $EUID -ne 0 ]]; then
    which sudo > /dev/null 2>&1 || { echo "You need to run this script as root" && exit 1 ; }
    sudo -H ./install.sh "$@"
else
    ./install.sh "$@"
fi
