#!/bin/bash

set -eux
# -e : stop when errors occurred
# -u : make it error when using undefined variables
# -x : output logs to stdout

SRC_DIR=${HOME}/src
TIG_DIR=${SRC_DIR}/tig

# clone tig to ${HOME}/src
if [[ ! -d "$TIG_DIR" ]]; then
  mkdir -p "$SRC_DIR"
  git clone https://github.com/jonas/tig.git "$TIG_DIR"
fi

cd "$TIG_DIR"

git pull

make configure
./configure
make prefix=/usr/local
sudo make install prefix=/usr/local

# ref. https://github.com/jonas/tig/blob/master/INSTALL.adoc
