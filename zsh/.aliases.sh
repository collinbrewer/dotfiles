# general
alias scr="screenify"
alias settitle="printf '\033]0;%s\007'"

# docker
alias dka='docker kill $(docker ps -q)'

# git + fzf
alias fgcob='git checkout $(git branch | sed "s/\*//" | fzf)'
alias fgcof='git checkout $(git ls-files -m | fzf)'
alias fgd='git diff $(git ls-files -m | fzf)'
alias fga='git add $(git ls-files --others --exclude-standard | fzf)'
alias fgap='git add -p $(git ls-files --others --exclude-standard | fzf)'

# vim is nvim
alias vim=nvim

# mux
alias mux=tmuxinator
alias fmux='mux $(ls ~/.config/tmuxinator | xargs -n 1 basename | cut -d\. -f1 | fzf)'

# fzf + ssh
alias fssh='ssh $(cat ~/.ssh/config | grep "Host " | grep -v "#" | sed "s/Host //" | fzf)'

# arch
alias open=xdg-open

# wsl
# alias open=explorer.exe
# alias synctime="sudo ntpdate pool.ntp.org"

# osx
# alias ctags="`brew --prefix`/bin/ctags"
# git
alias gsta="find . -maxdepth 1 -mindepth 1 -type d -exec sh -c '(echo {} && cd {} && git status -s && echo)' \;"
alias gda="find . -maxdepth 1 -mindepth 1 -type d -exec sh -c '(echo {} && cd {} && git diff && echo)' \;"
alias gro="git remote -v | head -n 1 | awk -F @ '{print \$2}' | awk -F ' ' '{print \$1}' | sed 's/:/\//g' | awk '{print \"http://\"\$1}' | xargs xdg-open"
