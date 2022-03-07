#!/usr/bin/env zsh

if [[ "$(uname -s)" == "Darwin" ]]; then
  echo 'Mac OS X'
  brew install stow asdf fzf nvim tig tmux httpie htop bat autojump exa ripgrep

  # https://github.com/junegunn/fzf#using-homebrew
  $(brew --prefix)/opt/fzf/install
else
  echo 'Linux (Untested)'
  sudo apt install stow bat ripgrep autojump exa

  # https://github.com/neovim/neovim/wiki/Installing-Neovim#ubuntu
  sudo add-apt-repository ppa:neovim-ppa/stable
  sudo apt-get update
  sudo apt-get install neovim
  sudo apt-get install python-dev python-pip python3-dev python3-pip

  # Install asdf
  asdf_dir=$HOME/.asdf
  cd $HOME

  if [ ! -d $asdf_dir ]; then
    echo "Installing asdf..."
    git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.9.0 $asdf_dir

    source ~/.zshrc || true
    echo "asdf installation complete"
  else
    echo "asdf already installed"
  fi
fi

echo 'Setup Development Perferences (Nvim, zsh....)'

mkdir -p ~/.config/nvim

cd ~/dotfiles

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

echo "You are all set!"
