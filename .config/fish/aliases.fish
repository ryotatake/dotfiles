fish_vi_key_bindings

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

if which memo > /dev/null ^&1
  function memosearch
    if [ ! -z "$argv" ]
      vim (memo grep "$argv" | fzf)
    else
      vim (memo list | fzf)
    end
  end
end
