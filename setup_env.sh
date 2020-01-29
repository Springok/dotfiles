#!/usr/bin/env bash

set -e

if ! [ -e $(command -v stow) ]; then
  if [ "$(uname)" == "Darwin" ]; then
    echo 'Mac OS X'
    brew install stow
  elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    echo 'Linux'
    sudo apt install stow
  fi
fi

cd ~

if [[ ! -d ~/dotfiles ]]; then
  git clone git@github.com:Springok/dotfiles.git ~/dotfiles
fi

cd dotfiles

stow git \
  zsh \
  nvim \
  tmux \
  ruby

exit 0
