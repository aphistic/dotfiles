#!/bin/bash

set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR

UNAMESTR=$(uname)

if [ $UNAMESTR == "Darwin" ]; then
    echo "Processing Darwin bootstrap"
    tar xf homemaker_darwin_amd64.tar.gz
    if [ -f homemaker ]; then
        rm homemaker
    fi
    ln -s homemaker_darwin_amd64/homemaker homemaker
elif [ $UNAMESTR == "Linux" ]; then
    ARCH=$(uname -m)
    LINUX_TYPE="amd64"
    HM_PACKAGE=homemaker_linux_amd64
    if [ $ARCH == "i686" ]; then
	LINUX_TYPE="386"
	HM_PACKAGE=homemaker_linux_386
    elif [ $ARCH == "armv7l" ]; then
	LINUX_TYPE="arm"
	HM_PACKAGE=homemaker_linux_arm
    else
        echo "Unknown linux arch"
	exit 1
    fi
    echo "Processing Linux ($LINUX_TYPE) bootstrap"
    tar xf ${HM_PACKAGE}.tar.gz
    if [ -f homemaker ]; then
        rm homemaker
    fi
    ln -s ${HM_PACKAGE}/homemaker homemaker
fi
