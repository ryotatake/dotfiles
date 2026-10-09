# 使い方

## vimのinstall

```
./vim_setup.sh
```

## 設定ファイルの反映

```sh
git clone https://github.com/ryotatake/dotfiles.git ~/dotfiles
make symlinks
```

## zsh

シェルの基本設定は [zimfw](https://zimfw.sh/) に任せている。
`.zshrc` が初回起動時に zimfw 本体と `.zimrc` のモジュールを `~/.zim` へ自動で取得するので、
`make symlinks` のあと zsh を起動するだけでよい。

モジュールの更新:

```sh
zimfw upgrade && zimfw update
```

## ツールのインストール

Homebrew で入れるものは `Brewfile` にまとめてある。

```sh
brew bundle
```

ruby / node / go / terraform は [mise](https://mise.jdx.dev/) で入れる。バージョンは `.config/mise/config.toml` にある。

```sh
mise install
```

Rust のツールは Makefile から:

```
make tools-setup
make tools
```

## 個別でインストールするツール

- [Zellij](https://zellij.dev/) 
