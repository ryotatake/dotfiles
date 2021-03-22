# Defining an abbreviation with global scope is slightly faster than universal scope.
abbr --add --global ll  "ls -lh --time-style=long-iso"
abbr --add --global la  "ll -a"
abbr --add --global rm  "rm -i"
abbr --add --global cp  "cp -i"
abbr --add --global mv  "mv -i"
abbr --add --global g   "git"
abbr --add --global agl 'ag --pager="less -R"'
abbr --add --global mux 'sh ~/.local/tmux_setup.sh'
