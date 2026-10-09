[[ -x /opt/homebrew/bin/brew ]] && eval "$(/opt/homebrew/bin/brew shellenv)"

# Zellij のペインなど非ログインシェルで毎回 ssh-add が走らないよう、ログイン時だけ鍵を読み込む
[[ ${OSTYPE} == darwin* ]] && ssh-add -q --apple-use-keychain
