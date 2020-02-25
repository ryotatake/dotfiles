set -x EDITOR vim

set -x FZF_DEFAULT_OPTS "--height 40% --layout=reverse --border --inline-info --preview 'head -100 {}'"
set -x FZF_DEFAULT_COMMAND 'ag --hidden --ignore .git -g ""'

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
end

if which rbenv > /dev/null
  status --is-interactive; and source (rbenv init -|psub)
end
