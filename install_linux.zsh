#!/usr/bin/env zsh

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

echo 'Setup Development Perferences (Nvim, Zim...)...'

folders=("git" "tig" "nvim" "pry" "tmux" "tmuxinator" "ctags" "zim" "clojure" "ruby")

for folder in "${folders[@]}"; do
  mkdir -p $HOME/.config/"$folder"
done

cd ~/dotfiles
cp ./git/.config/git/user_config.sample ~/.config/git/user_config

stow --verbose asdf \
  git \
  nvim \
  ruby \
  tmux \
  zsh \

echo "starting asdf plugins installation..."
cat ~/.tool-versions | cut -d' ' -f1 | grep "^[^\#]" | xargs -I{} asdf plugin add {}

echo "starting asdf installation..."
asdf install

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

echo "[Important!] Use your own email / username in ~/.config/git/user_config"

echo "Then You are all set!"
