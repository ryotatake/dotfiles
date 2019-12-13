set -x EDITOR vim
fish_vi_key_bindings

set -x FZF_DEFAULT_OPTS "--height 40% --layout=reverse --border --inline-info --preview 'head -100 {}'"
set -x FZF_DEFAULT_COMMAND 'ag --hidden --ignore .git -g ""'

set -x PATH /usr/local/bin $HOME/bin /sbin /usr/sbin /usr/bin $PATH

set -x PATH $HOME/.rbenv/bin $PATH
set -x PATH /usr/local/lib/rbenv/bin $PATH
set -x RBENV_ROOT /usr/local/lib/rbenv
if which rbenv > /dev/null
  status --is-interactive; and source (rbenv init -|psub)
end

#if [ "(uname)" = 'Darwin' ]
#  alias ls="ls -G"
#else
#  alias ls="ls --color=auto"
#end

alias la="ls -al"
alias ll="ls -l"
alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"
alias g="git"
