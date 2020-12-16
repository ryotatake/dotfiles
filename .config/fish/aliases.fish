#if [ "(uname)" = 'Darwin' ]
#  alias ls="ls -G"
#else
#  alias ls="ls --color=auto"
#end

alias ll="ls -lh --time-style=long-iso"
alias la="ll -a"
alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"
alias g="git"
alias agl='ag --pager="less -R"'
alias mux='sh ~/.local/tmux_setup.sh'

if which memo > /dev/null 2>&1
  function memosearch
    if [ ! -z "$argv" ]
      set file (memo grep "$argv" | fzf)
    else
      set file (memo list --fullpath | fzf)
    end

    if [ ! -z "$file" ]
      vim $file
    end
  end
end
alias memos="memosearch"
