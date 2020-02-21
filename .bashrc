# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# https://qiita.com/tak-onda/items/a90b63d9618d6b15c18c
# If not running interactively, don't do anything
#case $- in
#    *i*) exec fish;;
#      *) return;;
#esac

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

parse_git_branch()
{
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ [\1]/'
}

mkdircd()
{
  mkdir -p "$@" && eval cd "\"\$$#\""
}

# User specific aliases and functions
if [[ "$(uname)" = 'Darwin' ]]; then
  alias ls="ls -G"
else
  alias ls="ls --color=auto"
fi
alias la="ls -al"
alias ll="ls -l"
alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"
alias g="git"
export EDITOR=vim
export PATH=/usr/local/bin:$HOME/bin:/sbin:/usr/sbin:/usr/bin:$PATH
export PS1="\[\033[01;32m\]\u@\H(development)\[\033[01;34m\] \W\$(parse_git_branch) \n\$\[\033[00m\] "

[[ -f ~/.fzf.bash ]] && source ~/.fzf.bash
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border --inline-info --preview 'head -100 {}'"
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'

[[ -f ~/.bashrc.local ]] && source ~/.bashrc.local
