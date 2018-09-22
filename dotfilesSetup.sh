#!/bin/sh

#シンボリックリンクの作成
ln -sf ~/dotfiles/.vimrc ~/.vimrc
ln -sf ~/dotfiles/colors ~/.vim
ln -sf ~/dotfiles/indent ~/.vim

#プラグイン管理のためのVundle導入
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
