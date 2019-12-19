#!/bin/bash

set -eux
# -e : stop when errors occurred
# -u : make it error when using undefined variables
# -x : output logs to stdout

SRC_DIR=${HOME}/src
VIM_DIR=${SRC_DIR}/vim

# clone vim to ${HOME}/src
if [[ ! -d "$VIM_DIR" ]]; then
  mkdir -p "$SRC_DIR"
  git clone https://github.com/vim/vim.git "$VIM_DIR"
fi

cd "$VIM_DIR"

git pull

sudo make distclean

sudo ./configure \
  --with-features=huge \
  --enable-multibyte \
  --enable-luainterp=dynamic \
  --enable-gpm \
  --enable-cscope \
  --enable-fontset \
  --enable-fail-if-missing \
  --prefix=/usr/local \
  --enable-rubyinterp \
  --with-ruby-command="$(which ruby)"
  # If not installed lua
  #   @CentOS run `$ sudo yum install lua-devel ncurses-devel`
  #   @Ubuntu see https://vim-jp.org/docs/build_linux.html

sudo make
sudo make install
