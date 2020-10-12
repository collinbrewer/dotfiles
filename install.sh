#!/usr/bin/env bash

if [ -z "$HOME" ]; then echo "Seems you're \$HOMEless :("; exit 1; fi

DOTFILES=$HOME/.dotfiles

mkdir -p "$DOTFILES"
cd "$DOTFILES"
git init
git remote add origin git@github.com:collinbrewer/dotfiles.git
git pull origin master

echo
echo "Now just `stow git zsh screen ...`
