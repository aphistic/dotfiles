#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd $DIR
tar xf homemaker_linux_amd64.tar.gz
rm homemaker
ln -s homemaker_linux_amd64/homemaker homemaker
