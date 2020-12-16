set -x EDITOR vim

set -x FZF_DEFAULT_OPTS "--height 40% --layout=reverse --border --inline-info"
set -x FZF_DEFAULT_COMMAND 'ag --hidden --ignore .git -g ""'

# for jethrokuan/fzf
set -x FZF_LEGACY_KEYBINDINGS 0
set -x FZF_OPEN_COMMAND $FZF_DEFAULT_COMMAND
set -x FZF_OPEN_OPTS "--preview 'bat --style=numbers --color=always {} | head -100'"
set -x FZF_FIND_FILE_OPTS $FZF_OPEN_OPTS

set -x PATH /usr/local/bin $HOME/bin /sbin /usr/sbin /usr/bin $PATH

if test -d $HOME/.local/bin
  set -x PATH $HOME/.local/bin $PATH
end

if test -d $HOME/.goenv
  set -x GOENV_ROOT $HOME/.goenv
  set -x PATH $GOENV_ROOT/bin $PATH
  status --is-interactive; and source (goenv init -|psub)
  set -x PATH $GOPATH/bin $PATH
end

if test -d $HOME/.cargo/bin
  set -x PATH $HOME/.cargo/bin $PATH
end

if test -d $HOME/.rbenv/bin
  set -x PATH $HOME/.rbenv/bin $PATH
end

if test -d /usr/local/lib/rbenv
  set -x PATH /usr/local/lib/rbenv/bin $PATH
  set -x RBENV_ROOT /usr/local/lib/rbenv
end

if which rbenv > /dev/null 2>&1
  status --is-interactive; and source (rbenv init -|psub)
end

if test -d /usr/local/lib/nodenv
  set -x NODENV_ROOT /usr/local/lib/nodenv
  set -x PATH $NODENV_ROOT/bin $PATH
  nodenv init - fish | source
end

if which yarn > /dev/null 2>&1
  set -x PATH (yarn global bin) $PATH
end
