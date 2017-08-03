#!/bin/bash

set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR

UNAMESTR=$(uname)

echo $

if [ $UNAMESTR == "Darwin" ]; then
    echo "Processing Darwin bootstrap"
    tar xf homemaker_darwin_amd64.tar.gz
    if [ -f homemaker ]; then
        rm homemaker
    fi
    ln -s homemaker_darwin_amd64/homemaker homemaker
elif [ $UNAMESTR == "Linux" ]; then
    echo "Processing Linux bootstrap"
    tar xf homemaker_linux_amd64.tar.gz
    if [ -f homemaker ]; then
        rm homemaker
    fi
    ln -s homemaker_linux_amd64/homemaker homemaker
fi
