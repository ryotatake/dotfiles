#!/bin/bash
set -euo pipefail

DOTPATH=$(cd "$(dirname "$0")" && pwd)
BACKUP_DIR="$HOME/.backup"

# リポジトリ直下には Claude Code の .claude など未追跡のものもできるため、~ に張る対象はここに列挙したものに限る
TARGETS=(
  .bash_profile
  .bashrc
  .gitconfig
  .gitignore_global
  .gvimrc
  .textlintrc
  .vimrc
  .zimrc
  .zprofile
  .zshrc
  .vim
  .config/mise
  .config/atcoder-cli-nodejs/cpp
)

for target in "${TARGETS[@]}"; do
  dest="$HOME/$target"
  mkdir -p "$(dirname "$dest")"
  # 2 回目以降の実行で、前回退避した実ファイルをシンボリックリンクで上書きしないよう、実ファイルだけを退避する
  if [ -e "$dest" ] && [ ! -L "$dest" ]; then
    mkdir -p "$BACKUP_DIR/$(dirname "$target")"
    mv -v "$dest" "$BACKUP_DIR/$target"
  fi
  ln -sfnv "$DOTPATH/$target" "$dest"
done
