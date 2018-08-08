# zplug {{{

# install zplug, if necessary
if [[ ! -d ~/.zplug ]]; then
  export ZPLUG_HOME=~/.zplug
  git clone https://github.com/zplug/zplug $ZPLUG_HOME
fi

if [[ ! -d ~/.vim/bundle ]]; then
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

source ~/.zplug/init.zsh
source ~/.zshrc_helper

# zplug "plugins/vi-mode", from:oh-my-zsh

zplug "b4b4r07/enhancd", use:init.sh
zplug "junegunn/fzf", as:command, hook-build:"./install --bin", use:"bin/{fzf-tmux,fzf}"

zplug "denysdovhan/spaceship-prompt", use:spaceship.zsh, from:github, as:theme
SPACESHIP_USER_SHOW=false
SPACESHIP_HOST_SHOW=false
SPACESHIP_VI_MODE_SHOW=false
# SPACESHIP_CHAR_SYMBOL='🍺 '
# SPACESHIP_RUBY_SYMBOL='🔥  '

# zplug 'dracula/zsh', as:theme
# setopt prompt_subst # Make sure prompt is able to be generated properly.
# zplug "caiogondim/bullet-train.zsh", use:bullet-train.zsh-theme, defer:3 # defer until other plugins like oh-my-zsh is loaded
# BULLETTRAIN_PROMPT_ORDER=(
#   time
#   status
#   dir
#   ruby
#   git
# )

zplug "zsh-users/zsh-autosuggestions", defer:3

# zim {{{
zplug "zimfw/zimfw", use:"init.zsh", hook-build:"ln -sf $ZPLUG_REPOS/zimfw/zimfw ~/.zim"

zmodules=(directory environment history input git git-info ssh utility \
  syntax-highlighting history-substring-search prompt completion)

zhighlighters=(main brackets pattern cursor root)
# }}}

if ! zplug check --verbose; then
  zplug install
fi

zplug load #--verbose

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=240'

source ~/.zplug/repos/junegunn/fzf/shell/key-bindings.zsh
source ~/.zplug/repos/junegunn/fzf/shell/completion.zsh

export FZF_COMPLETION_TRIGGER=';'
export FZF_TMUX=1

# }}}

# Disable flow control then we can use ctrl-s to save in vim
# Disable flow control commands (keeps C-s from freezing everything)
stty start undef
stty stop undef

# asdf setting
. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash

# User configuration
export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH="$PATH:$HOME/bin"

# this setting is also affect language in Vim
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
########################
# General
########################

# For pair
pairg() { ssh -t $1 ssh -o 'StrictHostKeyChecking=no' -o 'UserKnownHostsFile=/dev/null' -p $2 -t vagrant@localhost 'tmux attach' }
pairh() { ssh -S none -o 'ExitOnForwardFailure=yes' -R $2\:localhost:22222 -t $1 'watch -en 10 who' }

alias sshc='vim ~/.ssh/config'
alias fixssh='eval $(tmux showenv -s SSH_AUTH_SOCK)'

# For vagrant
alias va=vagrant
alias vup='va up'
alias vssh='va ssh'
alias vhalt='va halt'
alias vhlat='va halt'

alias la='ls -l -a'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias c='clear'
alias aq='ag -Q'
alias px='ps aux'
alias ep='exit'

alias vt='vim -c :CtrlP'

# Git
alias gs='git status' # gwS, gws
alias gcom='git checkout master'
alias gRs='git remote show origin'
alias gbda='git branch --merged | egrep -v "(^\*|master|dev|nerv)" | xargs git branch -d'
alias glg='git log --stat --max-count=10 --pretty=format:"${_git_log_medium_format}"'
alias gddd='gwd origin/master...'
alias gddde='vim `gddd --name-only`'
alias gwe='vim `git diff --name-only`'
alias gie='vim `git diff --cached --name-only`'
alias gbs='git branch | grep -v spring'
alias gcoc='git checkout nerv_ck'
alias gcoh='git checkout nerv'

########################
# Project Related
########################

# export USE_BOOTSNAP=1
alias krpu='rpu kill'

alias dump_db='~/helper/dumpdb.sh'

# Nerv Project
alias ck='cd ~/nerv_ck'
alias hk='cd ~/nerv'

# Gems
alias be='bundle exec'
alias seki='be sidekiq'
alias stopme='be spring stop'
alias rubo='cop master...'
alias rake='be rake'

# Rails
alias rc='rails console'
alias rct='rails console test'
alias rch="tail -f ~/.pry_history | grep -v 'exit'"

alias skip_env="SKIP_PATCHING_MIGRATION='skip_any_patching_related_migrations'"
alias disboot="USE_BOOTSNAP=0"
alias mig='rake db:migrate'
alias migs='rake db:migrate:status'
alias roll='rake db:rollback'
alias rock!='roll && mig'
alias smig='skip_env mig'

alias olog='tail -f log/lograge_development.log'
alias clog='cat /dev/null >! log/lograge_development.log && cat /dev/null >! log/development.log'

# Test
alias mi='be ruby -Itest'
alias mii='rake test'
alias testba='rake test:concepts && rake test:forms && rake test:models'

# Amoeba
alias ku='[[ -f tmp/pids/unicorn.pid ]] && kill `cat tmp/pids/unicorn.pid`'

########################
# Jump Into Config File
########################
#
alias zshrc='vim ~/.zshrc'
alias sozsh='source ~/.zshrc'
alias vimrc='vim ~/.vimrc'
alias en='vim .env'
alias mc='mailcatcher --http-ip 0.0.0.0'
alias kmc='pkill -fe mailcatcher'

# Git pager setting
export LESS=R
# use emacs mode in command line
bindkey -e
