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

# fzf + ssh
alias fssh='ssh $(cat ~/.ssh/config | grep "Host " | grep -v "#" | sed "s/Host //" | fzf)'

# arch
alias open=xdg-open

# wsl
# alias open=explorer.exe
# alias synctime="sudo ntpdate pool.ntp.org"

# osx
# alias ctags="`brew --prefix`/bin/ctags"
