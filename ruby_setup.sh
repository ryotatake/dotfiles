#!/bin/sh

# Use this file when install rbenv and ruby.

set -eux
# -e : stop when errors occurred
# -u : make it error when using undefined variables
# -x : output logs to stdout

# install rbenv
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
exec $SHELL -l

# install ruby-build
git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build

# install tools for ruby
if [ -e /etc/debian-version ]; then
  sudo apt-get update
  sudo apt-get install -y libssl-dev libreadline-dev zlib1g-dev
elif [ -e /etc/redhat-release ]; then
  sudo yum install -y openssl-devel readline-devel zlib-devel
fi

# Then, run under commands.
# $ rbenv install {version}
# $ rbenv global {version}
