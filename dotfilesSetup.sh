#!/bin/bash

#シンボリックリンクの作成
ln -sf ~/dotfiles/.vimrc ~/.vimrc
ln -sf ~/dotfiles/.vim ~/.vim
ln -sf ~/dotfiles/.bashrc ~/.bashrc
ln -sf ~/dotfiles/.bash_profile ~/.bash_profile
ln -sf ~/dotfiles/.gitconfig ~/.gitconfig
ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -sf ~/dotfiles/.irbrc ~/.irbrc
ln -sf ~/dotfiles/.inputrc ~/.inputrc
if [[ -d ~/.config/fish ]]; then
  ln -sf ~/dotfiles/.config/fish/config.fish ~/.config/fish/config.fish
fi

#tmuxのプラグイン管理
if [[ ! -d ~/.tmux/plugins/tpm ]]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi
