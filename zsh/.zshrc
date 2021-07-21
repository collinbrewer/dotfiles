# load up antigen
zstyle :omz:plugins:ssh-agent identities id_rsa
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
export EDITOR='nvim'

vim_prompt() {
  if [ ! -z $VIMRUNTIME ]; then
    echo ":%F{green}sh ";
  fi
}

# Add NVM to PATH
[ -z "/usr/share/nvm/init-nvm.sh" ] && source /usr/share/nvm/init-nvm.sh
#
# path
export PATH=/Users/collinbrewer/Library/Python/3.6/bin:$PATH

# load external scripts
export PATH=~/.scripts:$PATH

export KEYTIMEOUT=1

source ~/.aliases.sh

# load up android
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk
export ANDROID_HOME=/home/collinbrewer/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
