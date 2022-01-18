#!/bin/bash
set -eux

# `sudo amazon-linux-extras install epel -y`を利用すると最新のfishが利用できないのでCentOS用のものを利用する
sudo cd /etc/yum.repos.d/
sudo wget https://download.opensuse.org/repositories/shells:fish:release:3/CentOS_7/shells:fish:release:3.repo
sudo yum install fish util-linux-user -y
sudo chsh -s `which fish`
fish
