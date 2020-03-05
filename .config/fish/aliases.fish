fish_vi_key_bindings

#if [ "(uname)" = 'Darwin' ]
#  alias ls="ls -G"
#else
#  alias ls="ls --color=auto"
#end

alias la="ls -lah"
alias ll="ls -lh"
alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"
alias g="git"
alias agl='ag --pager="less -R"'

if which memo > /dev/null 2>&1
  function memosearch
    if [ ! -z "$argv" ]
      vim (memo grep "$argv" | fzf)
    else
      vim (memo list --fullpath | fzf)
    end
  end
end
alias memos="memosearch"
