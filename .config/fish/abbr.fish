# Defining an abbreviation with global scope is slightly faster than universal scope.
abbr --add --global ,r    "source ~/.config/fish/config.fish"

abbr --add --global ls    "ls --color=auto"
abbr --add --global ll    "ls -lh --color=auto --time-style=long-iso"
abbr --add --global la    "ls -lah --color=auto --time-style=long-iso"
abbr --add --global rm    "rm -i"
abbr --add --global cp    "cp -i"
abbr --add --global mv    "mv -i"

abbr --add --global g     "git"
abbr --add --global gs    "git status"
abbr --add --global ga    "git add"
abbr --add --global gap   "git add --patch"
abbr --add --global gc    "git commit"
abbr --add --global gca   "git commit --all"
abbr --add --global gd    "git diff"
abbr --add --global gl    "git log"
abbr --add --global glp   "git log --patch"
abbr --add --global gb    "git branch -v"
abbr --add --global gco   "git checkout"
abbr --add --global gcof  'git for-each-ref --format="%(refname:short)|||%(authordate:short)|||%(authorname)|||%(contents:subject)" --sort=-authordate refs/heads | column -ts "|||" | fzf --prompt "CHECKOUT BRANCH> " --preview "git log --color=always {1}" --nth=1,3 --delimiter=" {2,}" | awk \'{ print $1 }\' | xargs git checkout'
abbr --add --global gcofr 'git for-each-ref --format="%(refname:short)|||%(authordate:short)|||%(authorname)|||%(contents:subject)" --sort=-authordate refs/heads refs/remotes | column -ts "|||" | fzf --prompt "CHECKOUT BRANCH> " --preview "git log --color=always {1}" --nth=1,3 --delimiter=" {2,}" | awk \'{ print $1 }\' | xargs git checkout'

abbr --add --global agl   'ag --pager="less -R"'
abbr --add --global mux   'sh ~/.local/tmux_setup.sh'
abbr --add --global memos 'memosearch'
