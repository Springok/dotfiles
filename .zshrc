# zplug {{{

# install zplug, if necessary
if [[ ! -d ~/.zplug ]]; then
  export ZPLUG_HOME=~/.zplug
  git clone https://github.com/zplug/zplug $ZPLUG_HOME
fi

source ~/.zplug/init.zsh

# zplug "plugins/vi-mode", from:oh-my-zsh
zplug "plugins/chruby",  from:oh-my-zsh
zplug "plugins/bundler", from:oh-my-zsh
zplug "plugins/rails",   from:oh-my-zsh

# zplug "b4b4r07/enhancd", use:init.sh
zplug "junegunn/fzf", as:command, hook-build:"./install --bin", use:"bin/{fzf-tmux,fzf}"

# zplug 'dracula/zsh', as:theme
zplug "denysdovhan/spaceship-zsh-theme", use:spaceship.zsh, from:github, as:theme
SPACESHIP_USER_SHOW=false
SPACESHIP_HOST_SHOW=false
SPACESHIP_VI_MODE_SHOW=false
SPACESHIP_PROMPT_SYMBOL='🍺 '
SPACESHIP_RUBY_SYMBOL='🔥  '

zplug "zsh-users/zsh-autosuggestions", defer:3

# zim {{{
zplug "zimframework/zim", as:plugin, use:"init.zsh", hook-build:"ln -sf $ZPLUG_REPOS/zimframework/zim ~/.zim"

zmodules=(directory environment history input git spectrum ssh utility meta \
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
pairh() { ssh -S none -o 'ExitOnForwardFailure=yes' -R $2\:localhost:$2 -t $1 'watch -en 10 who' }

# For vagrant
alias va=vagrant
alias vup='va up'
alias vssh='va ssh'
alias vhalt='va halt'
alias vhlat='va halt'

alias tm='tmt'

alias la='ls -l -a'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias c='clear'
alias aq='ag -Q'
alias px='ps aux'
alias ep='exit'

alias vt='vim -c :CtrlP'

alias gs='git status'
alias gcom='git checkout master'
alias ggpush='gpc'
alias ggpull='git pull origin $(git_current_branch)'
alias gRs='git remote show origin'
alias gbda='git branch --merged | egrep -v "(^\*|master|dev)" | xargs git branch -d'
alias glg='git log --stat --max-count=10 --pretty=format:"${_git_log_medium_format}"'
alias gddd='git diff master...'
alias gd='git diff'

########################
# Project Related
########################

alias pa!='[[ -f config/puma.rb ]] && RAILS_RELATIVE_URL_ROOT=/`basename $PWD` bundle exec puma -C $PWD/config/puma.rb'
alias pa='[[ -f config/puma.rb ]] && RAILS_RELATIVE_URL_ROOT=/`basename $PWD` bundle exec puma -C $PWD/config/puma.rb -d'
alias kpa='bundle exec pumactl -P tmp/pids/puma.pid stop'
alias kap='kpa'

# Nerv CK alias
alias ck='cd ~/nerv_ck'
alias dump_ck='~/helper/dumpdb_ck.sh'

# Nerv HK
alias hk='cd ~/nerv'
alias dump_hk='~/helper/dumpdb.sh'

# Gems
alias be='bundle exec'
alias seki='be sidekiq'
alias stopme='be spring stop'
alias rubo='be rubocop'
alias rake='be rake'

# Rails
alias rc='bin/rails console'
alias rct='bin/rails console test'
alias skip_env="SKIP_PATCHING_MIGRATION='skip_any_patching_related_migrations'"
alias mig='bin/rake db:migrate'
alias migs='bin/rake db:migrate:status'
alias roll='bin/rake db:rollback'
alias rock!='roll && mig'
alias smig='skip_env mig'

alias olog='tail -f log/development.log'
alias clog='cat /dev/null > log/development.log'

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

# Git pager setting
export LESS=R
# use emacs mode in command line
bindkey -e

rmailcatcher() {
  local pid=$(ps h -C ruby -o pid,args | noglob grep '/bin/mailcatcher --http-ip' | cut -d' ' -f 1)
  if [[ -n $pid ]]; then
    kill $pid && echo "MailCatcher process $pid killed."
  else
    nohup mailcatcher --http-ip 0.0.0.0 > ~/.nohup/mailcatcher.out 2>&1&
    disown %nohup
  fi
}

# From Upcase tmux course
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
