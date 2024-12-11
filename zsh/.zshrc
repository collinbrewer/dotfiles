plugins=(git ssh-agent) # kubectl)
#
# zstyle :omz:plugins:ssh-agent agent-forwarding on
# zstyle :omz:plugins:ssh-agent identities id_rsa appsumo.pem ogg-vpc-sr375.pem

# load up antigen
# zstyle :omz:plugins:ssh-agent identities id_rsa
# source /usr/share/zsh/share/antigen.zsh
[ -f /opt/homebrew/share/antigen/antigen.zsh ] && source /opt/homebrew/share/antigen/antigen.zsh
# source /opt/homebrew/share/antigen/antigen.zsh
antigen init ~/.antigenrc

ssh-add --apple-use-keychain ~/.ssh/id_rsa

# completions
fpath=(~/.zsh/completions $fpath)
fpath+=~/.zfunc
autoload -Uz compinit
compinit -u

# .zshrc
# autoload -U promptinit; promptinit
# prompt pure

# Automatically list directory contents on `cd`.
# auto-ls () { ls -G; }
# chpwd_functions=( auto-ls $chpwd_functions )

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*" 2> /dev/null'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# vim 4eva
export EDITOR='nvim'

# path
export PATH=/Users/collinbrewer/Library/Python/3.6/bin:$PATH

# load external scripts
export PATH=~/.scripts:$PATH

export KEYTIMEOUT=1

source ~/.aliases.sh

# gpg
GPG_TTY=$(tty)
export GPG_TTY
