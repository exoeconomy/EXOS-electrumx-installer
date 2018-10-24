#!/bin/bash
if [ -d ~/.electrumx-civx-installer ]; then
    echo "~/.electrumx-civx-installer already exists."
    echo "Either delete the directory or run ~/.electrumx-civx-installer/install.sh directly."
    exit 1
fi
if which git > /dev/null 2>&1; then
    git clone https://github.com/exofoundation/electrumx-civx-installer ~/.electrumx-civx-installer
else
    which wget > /dev/null 2>&1 && which unzip > /dev/null 2>&1 || { echo "Please install git or wget and unzip" && exit 1 ; }
    wget https://github.com/exofoundation/electrumx-civx-installer/archive/master.zip -O /tmp/electrumx-civx-master.zip
    unzip /tmp/electrumx-civx-master.zip -d ~/.electrumx-civx-installer
    rm /tmp/electrumx-civx-master.zip
fi
cd ~/.electrumx-civx-installer/
if [[ $EUID -ne 0 ]]; then
    which sudo > /dev/null 2>&1 || { echo "You need to run this script as root" && exit 1 ; }
    sudo -H ./install.sh "$@"
else
    ./install.sh "$@"
fi
