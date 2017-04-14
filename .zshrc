# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

source /usr/local/share/chruby/chruby.sh
test -e /usr/local/share/chruby/auto.sh && source /usr/local/share/chruby/auto.sh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="spaceship"
SPACESHIP_PREFIX_HOST=" @ "

#Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions git-extras)

# Disable flow control then we can use ctrl-s to save in vim editor
# Disable flow control commands (keeps C-s from freezing everything)
stty start undef
stty stop undef

# User configuration
export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH="$PATH:$HOME/bin"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

########################
# General
########################

alias tm='tmux attach || tmux new'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias c='clear'
alias aq='ag -Q'

alias vt='vim -c :CtrlP'
alias va='cd /vagrant'
alias gl='git log'
alias gdn='git diff --no-ext-diff --word-diff'

########################
# Project Related
########################

# CK project
alias nerv_ck='cd ~/nerv'
alias pukill_ck='bundle exec pumactl -P /home/vagrant/nerv/tmp/pids/puma.pid stop'
alias punerv_ck='RAILS_RELATIVE_URL_ROOT=/nerv bundle exec puma -d -C config/puma.rb config.ru'
alias pupry_ck='RAILS_RELATIVE_URL_ROOT=/nerv bundle exec puma -C config/puma.rb config.ru'
alias dump_db_ck='~/helper/dumpdb_ck.sh'

# HK project
alias nerv='cd ~/nerv2'
alias pukill='bundle exec pumactl -P /home/vagrant/nerv2/tmp/pids/puma.pid stop'
alias punerv='RAILS_RELATIVE_URL_ROOT=/nerv2 bundle exec puma -d -C config/puma.rb config.ru'
alias pupry='RAILS_RELATIVE_URL_ROOT=/nerv2 bundle exec puma -C config/puma.rb config.ru'
alias dump_db='~/helper/dumpdb.sh'

# Gems
alias be='bundle exec'
alias seki='be sidekiq'
alias stopme='be spring stop'
alias rubo='be rubocop'
alias rake='be rake'

# Rails
alias rc='bin/rails console'
alias skip_env="SKIP_PATCHING_MIGRATION='skip_any_patching_related_migrations'"
alias mig='bin/rake db:migrate'
alias migs='bin/rake db:migrate:status'
alias roll='bin/rake db:rollback'
alias rock!='roll && mig'
alias smig='skip_env mig'

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
alias gcon='vim ~/.gitconfig'
alias zshrc='vim ~/.zshrc'
alias sozsh='source ~/.zshrc'
alias vimrc='vim ~/.vimrc.local'
alias en='vim .env'

# You may need to manually set your language environment
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

export EDITOR='vim'
# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

rmailcatcher() {
  local pid=$(ps h -C ruby -o pid,args | noglob grep '/bin/mailcatcher --http-ip' | cut -d' ' -f 1)
  if [[ -n $pid ]]; then
    kill $pid && echo "MailCatcher process $pid killed."
  else
    nohup mailcatcher --http-ip 0.0.0.0 > ~/.nohup/mailcatcher.out 2>&1&
    disown %nohup
  fi
}


# tmt(){
#   # local session_name="lalalas"
#   local session_name="$(basename "$pwd" | tr . -)"
#   tmux attach || tmux new -As $session_name
# }

tmt(){
session_name="$(basename "$PWD" | tr . -)"

session_exists() {
  tmux list-sessions | sed -E 's/:.*$//' | grep -q "^$session_name$"
}

not_in_tmux() {
  [ -z "$TMUX" ]
}

if not_in_tmux; then
  tmux new-session -As "$session_name"
else
  if ! session_exists; then
    (TMUX='' tmux new-session -Ad -s "$session_name")
  fi
  tmux switch-client -t "$session_name"
fi
}
