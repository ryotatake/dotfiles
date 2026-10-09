[[ -x /opt/homebrew/bin/brew ]] && eval "$(/opt/homebrew/bin/brew shellenv)"

# 非対話シェル（VS Code のタスクや Claude Code など）でも ruby や node が引けるよう、
# ログイン時に shims を PATH に入れておく。対話シェルでは .zshrc の activate が実バイナリを前に置く
(( ${+commands[mise]} )) && eval "$(mise activate zsh --shims)"

# Zellij のペインなど非ログインシェルで毎回 ssh-add が走らないよう、ログイン時だけ鍵を読み込む
[[ ${OSTYPE} == darwin* ]] && ssh-add -q --apple-use-keychain
