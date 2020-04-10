########################
# Zplug
########################
# install zplug, if necessary
if [[ ! -d ~/.zplug ]]; then
  export ZPLUG_HOME=~/.zplug
  git clone https://github.com/zplug/zplug $ZPLUG_HOME
fi

source ~/.zplug/init.zsh

zplug "junegunn/fzf", as:command, hook-build:"./install --bin", use:"bin/{fzf-tmux,fzf}"

zplug "modules/git", from:prezto

zplug "modules/syntax-highlighting", from:prezto
zstyle ':prezto:module:syntax-highlighting' color 'yes'

zplug "modules/prompt", from:prezto
zstyle ':prezto:module:prompt' theme 'pure'

zplug "modules/environment", from:prezto
zplug "modules/completion", from:prezto
zplug "modules/history", from:prezto

# If this module is used in conjunction with the syntax-highlighting module, this module must be loaded after the syntax-highlighting module.
zplug "modules/history-substring-search", from:prezto
zstyle ':prezto:module:history-substring-search' color 'yes'

zplug "modules/autosuggestions", from:prezto
zstyle ':prezto:module:autosuggestions' color 'yes'
zstyle ':prezto:module:autosuggestions:color' found 'fg=white'

zplug "modules/rsync", from:prezto
zplug "modules/directory", from:prezto

if ! zplug check --verbose; then
  zplug install
fi

zplug load #--verbose

source ~/.zplug/repos/junegunn/fzf/shell/key-bindings.zsh
source ~/.zplug/repos/junegunn/fzf/shell/completion.zsh

export FZF_TMUX=1

########################
# General
########################

source ~/.zshrc_helper

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
export LC_CTYPE=en_US.UTF-8

# For pair
pairg() { ssh -t $1 ssh -o 'StrictHostKeyChecking=no' -o 'UserKnownHostsFile=/dev/null' -p $2 -t vagrant@localhost 'tmux attach' }
pairh() { ssh -S none -o 'ExitOnForwardFailure=yes' -R $2\:localhost:22222 -t $1 'watch -en 10 who' }

# Use nvim
alias e='nvim'

if type nvim > /dev/null 2>&1; then
  alias vim='nvim'
fi

alias sshc='e ~/.ssh/config'
alias setup_tags='ctags -R'

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

# Git
alias gs='git status'
alias gcom='git checkout master'
alias gRs='git remote show origin'
alias gRp='git remote show origin | grep patch'
alias gRf='git remote show origin | grep feature'
alias gbda='git branch --merged | egrep -v "(^\*|master|dev|nerv)" | xargs git branch -d'
alias glg='git log --stat --max-count=10 --pretty=format:"${_git_log_medium_format}"'
alias gddd='gwd origin/master...'
alias gdde='e `gddd --name-only`'
alias gddn='gddd --name-only | cat'
alias gwe='e `git diff --name-only`'
alias gie='e `git diff --cached --name-only`'
alias gbs='git branch | grep -v spring'
alias gcoc='git checkout nerv_ck'

# JavaScript
alias nodejs=node

########################
# Project Related
########################

# export USE_BOOTSNAP=1
alias krpu='rpu kill'
alias pru='rpu'

# Yarn
alias ys='yarn start'
alias yf="yarn prettier --config .prettierrc --write 'src/**/*.{js,jsx,json,css,scss,md}'"
alias yt='yarn test'
alias ycop='yarn eslint --fix-dry-run src/'

# Nerv Project
alias ck='cd ~/nerv_ck'
alias hk='cd ~/nerv'
alias angel='cd ~/angel'

alias ch_pw='rails runner /vagrant/synced/ch_pw.rb'
alias e_pw='vim /vagrant/synced/ch_pw.rb'
alias dump_db='/vagrant/scripts/db_dump.rb && ch_pw'
alias dump_db2='/vagrant/scripts/dump_db.zsh'
alias cd_sync='cd /vagrant/synced/'

# Gems
alias be='bundle exec'
alias seki='be sidekiq'
alias stopme='be spring stop'
alias copm='cop master...'
alias rake='be rake'

# Rails
alias rc='rails console'
alias rct='rails console test'
alias rch="tail -f ~/.pry_history | grep -v 'exit'"

alias skip_env="SKIP_PATCHING_MIGRATION='skip_any_patching_related_migrations'"
alias disboot="USE_BOOTSNAP=0"
alias mig='rails db:migrate'
alias migs='rails db:migrate:status'
alias roll='rails db:rollback'
alias rock!='roll && mig'
alias smig='skip_env mig'

alias olog='tail -f log/development.log'
alias otlog='tail -f log/test.log'
alias clog='cat /dev/null >! log/lograge_development.log && cat /dev/null >! log/development.log'
alias ctlog='cat /dev/null >! log/lograge_test.log && cat /dev/null >! log/test.log'

# Test
alias mi='rails test'
alias testba='rails test test/controllers test/concepts test/forms test/models'

# Amoeba
alias ku='[[ -f tmp/pids/unicorn.pid ]] && kill `cat tmp/pids/unicorn.pid`'

# Clojure
alias l='lein'
alias repl='l repl'

########################
# Jump Into Config File
########################
alias zshrc='e ~/.zshrc'
alias sozsh='source ~/.zshrc'
alias vimrc='e ~/.config/nvim/init.vim'
alias en='e .env'
alias mc='mailcatcher --http-ip 0.0.0.0 ; seki'
alias kmc='pkill -fe mailcatcher'

# Git pager setting
export LESS=R

# Fix GPG
export GPG_TTY=$(tty)

# use emacs mode in command line
# bindkey -e

# use vim mode in command line
bindkey -v

# emacs style
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line

# module widget remap
export FZF_COMPLETION_TRIGGER=''
bindkey '^r' fzf-history-widget
bindkey '^t' fzf-completion
bindkey '^F' autosuggest-accept
bindkey '^p' history-substring-search-up
bindkey '^n' history-substring-search-down
