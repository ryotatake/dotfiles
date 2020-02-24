#!/bin/bash

# 正確ではない。あくまで自分が使っている環境だけを正しく判別できる。
get_os() {
  if [ -e /etc/debian_version ]; then
    echo "ubuntu"
  elif [ -e /etc/redhat-release ]; then
    echo "centos"
  elif [ $(uname) == 'Darwin' ]; then
    echo "darwin"
  else
    echo "unknown"
  fi
}

echo $(get_os)
