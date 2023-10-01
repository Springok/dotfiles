#!/usr/bin/env zsh

if [[ "$(uname -s)" == "Darwin" ]]; then
  echo 'You are in Mac OS X...'
  echo 'Install developer tools in general'
  brew install stow asdf fzf nvim git tig tmux httpie htop bat zoxide eza ripgrep wget gnu-sed gnu-time fd duf docker coreutils diff-so-fancy git-delta pandoc
else
  echo 'Linux (Script untested)...'
  sudo apt install stow bat ripgrep autojump eza wget

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

echo 'Setup Development Perferences (Nvim, Zim...)...'

folders=("git" "tig" "nvim" "pry" "tmux" "tmuxinator" "ctags" "zim")

for folder in "${folders[@]}"; do
  mkdir -p $HOME/.config/"$folder"
done

cd ~/dotfiles

stow --verbose asdf \
  git \
  nvim \
  ruby \
  tmux \
  zsh \

# TODO: hint for setup git user
# git config --global user.name "Your Name"
# git config --global user.email "your.email@example.com"

echo "starting asdf plugins installation..."
cat ~/.tool-versions | cut -d' ' -f1 | grep "^[^\#]" | xargs -I{} asdf plugin add {}

echo "starting asdf installation..."
asdf install

# https://github.com/junegunn/vim-plug#neovim
if [[ ! -f "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim ]]; then
  echo 'Install Vim Plug at first setup...'

  sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

  pip3 install pynvim

  nvim +PlugInstall +qall
fi

# https://github.com/tmux-plugins/tpm
if [[ ! -d $HOME/.config/tmux/plugins/tpm ]]; then
  echo 'Setup Tmux Plugin Manager(TMP)...'
  git clone https://github.com/tmux-plugins/tpm $HOME/.config/tmux/plugins/tpm
  tmux source $HOME/.config/tmux/tmux.conf

  echo 'Please Press tmux prefix key + I to install tmux plugins'
fi

# https://github.com/junegunn/fzf#using-homebrew
$(brew --prefix)/opt/fzf/install --key-bindings --completion --no-update-rc

# tmux-color256
# https://gpanders.com/blog/the-definitive-guide-to-using-tmux-256color-on-macos/
# sudo /usr/bin/tic -x ./tmux-256color.src

source ~/.zshrc

echo "You are all set!"
