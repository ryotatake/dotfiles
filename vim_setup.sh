#!/bin/sh

# Put this file to under vim/.

# Use this script after cloning vim.
# $ git clone https://github.com/vim/vim.git
# $ cd vim

set -eux
# -e : stop when errors occurred
# -u : make it error when using undefined variables
# -x : output logs to stdout

git pull

make distclean

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
  --with-ruby-command=/home/vagrant/.rbenv/shims/ruby # Change this path if you use another path. Check "$ which ruby".
  # If not installed lua
  #   @CentOS run `$ sudo yum install lua-devel ncurses-devel`
  #   @Ubuntu see https://vim-jp.org/docs/build_linux.html

sudo make
sudo make install
