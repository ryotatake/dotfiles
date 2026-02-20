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

## fish shell

### fish shellのinstall

[fish shell](<https://fishshell.com/>)にインストール方法が記載されているのでそれを参考に対応する。

### [fisher](<https://github.com/jorgebucaran/fisher>)とfisherプラグインのinstall

```sh
curl -sL https://git.io/fisher | source && fisher update
```

## ツールのインストール

```
make tools-setup
make tools
```

## 個別でインストールするツール

- [Zellij](https://zellij.dev/) 
