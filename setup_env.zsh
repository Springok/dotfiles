#!/usr/bin/env zsh

if [[ "$(uname -s)" == "Darwin" ]]; then
  echo 'Mac OS X'
  brew install stow asdf fzf nvim tig tmux httpie htop

  mkdir -p ~/.config/nvim

  stow --verbose git \
    zsh \
    nvim \
    tmux \
    clojure \
    ruby \
    asdf

  # Install Vim Plug at first setup
  sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

  pip3 install pynvim

  nvim +PlugInstall +qall

else
  echo 'Linux (Untested)'
  sudo apt install stow

  mkdir -p ~/.config/nvim

  stow --verbose git \
    zsh \
    nvim \
    tmux \
    clojure \
    ruby \
    asdf

  # TODO: install asdf
  # Install asdf
  asdf_dir=$HOME/.asdf
  cd $HOME

  if [ ! -d $asdf_dir ]; then
    echo "Installing asdf..."
    git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.0 $asdf_dir

    source ~/.zshrc || true
    echo "asdf installation complete"
  else
    echo "asdf already installed"
  fi
fi
