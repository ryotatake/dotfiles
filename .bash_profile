# .bash_profile

# Get the aliases and functions
# User specific environment and startup programs

PATH=$PATH:$HOME/.local/bin:$HOME/bin
PATH=$PATH:$HOME/bin:/usr/local/go/bin

export PATH
export PATH="$HOME/.rbenv/bin:$PATH"
if which rbenv > /dev/null; then
  eval "$(rbenv init -)"
fi

if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

export PATH="$HOME/.cargo/bin:$PATH"
