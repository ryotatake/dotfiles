# Defining an abbreviation with global scope is slightly faster than universal scope.
abbr --add --global ll    "ls -lh --time-style=long-iso"
abbr --add --global la    "ls -lah --time-style=long-iso"
abbr --add --global rm    "rm -i"
abbr --add --global cp    "cp -i"
abbr --add --global mv    "mv -i"

abbr --add --global g     "git"
abbr --add --global gs    "git status"
abbr --add --global ga    "git add"
abbr --add --global gap   "git add --patch"
abbr --add --global gc    "git commit --verbose"
abbr --add --global gca   "git commit --verbose --all"
abbr --add --global gd    "git diff"
abbr --add --global gl    "git log"
abbr --add --global gb    "git branch"
abbr --add --global gco   "git checkout"
abbr --add --global gcof  "git branch | fzf | xargs git checkout"

abbr --add --global agl   'ag --pager="less -R"'
abbr --add --global mux   'sh ~/.local/tmux_setup.sh'
abbr --add --global memos 'memosearch'
