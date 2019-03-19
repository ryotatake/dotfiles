#!/bin/sh

#シンボリックリンクの作成
ln -sf ~/dotfiles/.vimrc ~/.vimrc
ln -sf ~/dotfiles/colors ~/.vim/colors
ln -sf ~/dotfiles/indent ~/.vim/indent
ln -sf ~/dotfiles/.bashrc ~/.bashrc

#プラグイン管理のためのVundle導入
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
