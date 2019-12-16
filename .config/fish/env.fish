set -x EDITOR vim

set -x FZF_DEFAULT_OPTS "--height 40% --layout=reverse --border --inline-info --preview 'head -100 {}'"
set -x FZF_DEFAULT_COMMAND 'ag --hidden --ignore .git -g ""'

set -x PATH /usr/local/bin $HOME/bin /sbin /usr/sbin /usr/bin $PATH

set -x PATH $HOME/.rbenv/bin $PATH
if which rbenv > /dev/null
  status --is-interactive; and source (rbenv init -|psub)
end
