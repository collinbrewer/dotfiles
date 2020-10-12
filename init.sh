# sets up the repo, and adds an alias

git init --bare $HOME/.dotfiles-repo
alias dotfiles="$(which git) --git-dir=$HOME/.dotfiles-repo --work-tree=$HOME"
dotfiles config --local status.showUntrackedFiles no
dotfiles remote add origin git@github.com:collinbrewer/dotfiles.git

