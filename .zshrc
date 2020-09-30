# load up antigen
zstyle :omz:plugins:ssh-agent identities id_rsa sumo/id_rsa
source /usr/share/zsh/share/antigen.zsh
antigen init ~/.antigenrc

# completions
fpath=(~/.zsh/completions $fpath)
autoload -Uz compinit
compinit -u

# Automatically list directory contents on `cd`.
auto-ls () { ls -G; }
chpwd_functions=( auto-ls $chpwd_functions )

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*" 2> /dev/null'
# export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# vim 4eva
export EDITOR='vim'

vim_prompt() {
  if [ ! -z $VIMRUNTIME ]; then
    echo ":%F{green}sh ";
  fi
}

# Add NVM to PATH
source /usr/share/nvm/init-nvm.sh
#
# path
export PATH=/Users/collinbrewer/Library/Python/3.6/bin:$PATH

# ===========
# = aliases =
# ===========

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

alias gco='git checkout'
alias ga='git add'
# alias gb="git for-each-ref --sort='-authordate' --format='%(authordate)%09%(objectname:short)%09%(refname)' refs/heads | sed -e 's-refs/heads/--'"
alias gpu='git push -u origin `git rev-parse --abbrev-ref HEAD`'
alias gst='git status'
alias gd='git diff'
alias gdc='git diff --cached'
alias gap='git add -p'

# git + fzf
alias fgcob='git checkout $(git branch | sed "s/\*//" | fzf)'
alias fgcof='git checkout $(git ls-files -m | fzf)'
alias fgd='git diff $(git ls-files -m | fzf)'
alias fga='git add $(git ls-files --others --exclude-standard | fzf)'
alias fgap='git add -p $(git ls-files --others --exclude-standard | fzf)'

# fzf + ssh
alias fssh='ssh $(cat ~/.ssh/config | grep "Host " | grep -v "#" | sed "s/Host //" | fzf)'

# load external scripts
export PATH=~/.scripts:$PATH

export KEYTIMEOUT=1

source ~/.sumo.sh
source ~/.appsumo.sh
source ~/.arch.sh
source ~/.wsl.sh

# load up android
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk
export ANDROID_HOME=/home/collinbrewer/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
