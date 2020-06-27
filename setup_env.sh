#!/usr/bin/env bash

set -e

if ! command -v stow 2>&1 >&/dev/null; then
  echo 'Installing stow'
  if [ "$(uname)" == "Darwin" ]; then
    echo 'Mac OS X'
    brew install stow
  elif [ "$("(substr $(uname -s) 1 5)")" == "Linux" ]; then
    echo 'Linux'
    sudo apt install stow
  fi
fi

if [[ ! -d ~/dotfiles ]]; then
  git clone git@github.com:Springok/dotfiles.git ~/dotfiles
fi

cd ~/dotfiles

stow --verbose git \
  zsh \
  nvim \
  tmux \
  ruby \
  asdf

# Install asdf
asdf_dir=$HOME/.asdf
cd $HOME

if [ ! -d $asdf_dir ]; then
    echo "Installing asdf..."
    git clone https://github.com/asdf-vm/asdf.git $asdf_dir
    echo "asdf installation complete"
else
    echo "asdf already installed"
fi

asdf plugin-add java    || true
asdf plugin-add clojure || true
asdf plugin-add rust    || true
asdf plugin-add python  || true
asdf plugin-add golang  || true
asdf plugin-add ruby    || true
asdf plugin-add nodejs  || true

asdf install

exit 0
