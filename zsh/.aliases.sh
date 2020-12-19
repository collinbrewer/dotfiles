# general
alias scr="screenify"
alias settitle="printf '\033]0;%s\007'"

# docker
alias dce="docker-compose exec"
alias dcu="docker-compose up"
alias dcs="docker-compose stop"
alias dcr="docker-compose restart"
alias dcsu="docker-compose stop && docker-compose up"
alias dka='docker kill $(docker ps -q)'

# alias ctags="`brew --prefix`/bin/ctags"

# alias gb="git for-each-ref --sort='-authordate' --format='%(authordate)%09%(objectname:short)%09%(refname)' refs/heads | sed -e 's-refs/heads/--'"
alias gpu='git push -u origin `git rev-parse --abbrev-ref HEAD`'

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
alias open=explorer.exe
alias synctime="sudo ntpdate pool.ntp.org"

# appsumo
alias asdc="docker-compose -f local.yml"
alias asdce="docker-compose -f local.yml exec"

alias as_clean_tests="sudo find . -type d -name __pycache__ -exec rm -r {} \+"

alias ass='ssh asstage01 "docker ps --filter=\"name=django\" --format=\"{{.Status}}\t{{.Names}}\""'

# sumo
alias sumo-clean="rm -rf .builds && rm -rf .build && rm -rf client/build && git checkout client/build"
alias sumo-perf="node commands/monkey-puppet.js --executablePath='/Applications/Google Chrome.app/Contents/MacOS/Google Chrome' --headless=true"

