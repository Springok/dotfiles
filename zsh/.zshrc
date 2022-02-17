########################
# Zim
########################

# Remove older command from the history if a duplicate is to be added.
setopt HIST_IGNORE_ALL_DUPS

# -----------------
# Zim configuration
# -----------------

# asdf setting
# . $HOME/.asdf/asdf.sh
# . $HOME/.asdf/completions/asdf.bash

# --------------------
# Module configuration
# --------------------

# Set a custom prefix for the generated aliases. The default prefix is 'G'.
zstyle ':zim:git' aliases-prefix 'g'

# Customize the style that the suggestions are shown with.
# See https://github.com/zsh-users/zsh-autosuggestions/blob/master/README.md#suggestion-highlight-style
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=242'

# Set what highlighters will be used.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters.md
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

# ------------------
# Initialize modules
# ------------------

if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
  # Update static initialization script if it does not exist or it's outdated, before sourcing it
  source ${ZIM_HOME}/zimfw.zsh init -q
fi
source ${ZIM_HOME}/init.zsh

# }}} End configuration added by Zim install

########################
# General
########################

source ~/.zshrc_helper

[ -f ~/.ssh/abagile-dev.pem ] && ssh-add ~/.ssh/abagile-dev.pem 2&> /dev/null
[ -f ~/.ssh/id_pair ] && ssh-add ~/.ssh/id_pair 2&> /dev/null

# Disable flow control then we can use ctrl-s to save in vim
# Disable flow control commands (keeps C-s from freezing everything)
stty start undef
stty stop undef

# User configuration
export PATH=$HOME/bin:/usr/local/bin:/usr/local/opt/libpq/bin:/usr/local/opt/erlang@23/bin:$PATH
# export PATH=$HOME/bin:/usr/local/bin:/usr/local/opt/postgresql@10/bin:/usr/local/opt/erlang@23/bin:$PATH
#
export HOMEBREW_NO_AUTO_UPDATE=1

# this setting is also affect language in Vim
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8

export EDITOR='nvim'

# For pair
pairg() { ssh -t $1 ssh -o 'StrictHostKeyChecking=no' -o 'UserKnownHostsFile=/dev/null' -p $2 -t ${3:-vagrant}@localhost 'tmux attach' }
pairh() { ssh -S none -o 'ExitOnForwardFailure=yes' -R $2\:dev.localhost:22 -t $1 'watch -en 10 who' }

# Use nvim
alias e='nvim'
alias vdiff='nvim -d'

alias cat='bat --style=plain'

if type nvim > /dev/null 2>&1; then
  alias vim='nvim'
fi

alias sshc='e ~/.ssh/config'
alias setup_tags='ctags -R'

case `uname` in
  Darwin)
    alias ls='ls -G'
    alias ll='ls -l -a'
  ;;
  Linux)
    alias ls='ls --color=auto'
    alias ll='ls -l -a'
    alias grep='grep --color=auto'
  ;;
esac

alias grep='grep --color=auto'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias c='clear'
alias aq='ag -F'
alias px='ps aux'
alias ep='exit'
alias ag=rg

# Git
alias gs='git status'
alias gcom='git checkout master'
alias gRs='git remote show origin'
alias gRp='git remote show origin | grep patch'
alias gRf='git remote show origin | grep feature'
alias gbda='git branch --merged | egrep -v "(^\*|master|dev|nerv)" | xargs git branch -d'
alias glg='git log --stat --max-count=10 --pretty=format:"${_git_log_medium_format}"'
alias gdd='gwd origin/master...'
alias goc='gco'
alias gddd='gwd origin/master...'
alias gdde='e `gddd --name-only --relative`'
alias gddc='tig origin/master...'
alias gle='e `gcs --pretty=format: --name-only`'
alias gddn='gddd --name-only --relative | cat'
alias gwe='e `git diff --name-only --relative`'
alias gie='e `git diff --cached --name-only --relative`'
alias gbs='git branch | grep -v spring'
alias gbt='git checkout nerv_ck'

# JavaScript
alias nodejs=node

########################
# Project Related
########################

alias proj='cd ~/proj'

# export USE_BOOTSNAP=1
alias krpu='rpu kill'
alias pru='rpu'

# Nerv Projects
alias ck='cd ~/proj/nerv_ck'
alias hk='cd ~/proj/nerv'
alias sg='cd ~/proj/nerv_sg'
alias agl='cd ~/proj/angel'
alias ame='cd ~/proj/amoeba'
alias adam='cd clojure/projects/adam'
alias illy='cd clojure/projects/illy'
alias asuka='cd clojure/projects/asuka'
alias cpro='cd clojure/projects'
alias aoc='cd ~/proj/advent-of-code'

alias ch_pw='rails runner ~/proj/snippets/db/ch_pw.rb'
alias e_pw='vim ~/proj/snippets/db/ch_pw.rb'
alias e_db='vim ~/proj/snippets/db/db_mapping.yml'
alias dump_db='~/proj/vm/scripts/db_dump.rb && ch_pw'
alias dump_db_f='~/proj/vm/scripts/db_dump.rb -f && ch_pw'
alias dump_db2='~/proj/vm/scripts/dump_db.zsh'

# remote dev machine
# alias ch_pw='rails runner ~/synced/ch_pw.rb'
# alias e_pw='vim ~/synced/ch_pw.rb'
# alias dump_db3='~/vm/scripts/db_dump.rb -f && ch_pw'

# Gems
alias be='bundle exec'
alias rse='RAILS_RELATIVE_URL_ROOT=/`basename $PWD` be sidekiq'
alias rsk='RAILS_RELATIVE_URL_ROOT=/`basename $PWD` be rake sneakers:run'
alias stopme='be spring stop'
alias copm='cop master...'
alias rake='be rake'

# Rails
alias rc='RAILS_RELATIVE_URL_ROOT=/`basename $PWD` rails console'
alias rct='rails console test'
alias rch="tail -f ~/.pry_history | grep -v 'exit'"

alias skip_env="SKIP_PATCHING_MIGRATION='skip_any_patching_related_migrations'"
alias disboot="USE_BOOTSNAP=0"
alias mig='rails db:migrate'
alias migs='rails db:migrate:status'
alias roll='rails db:rollback'
alias rock!='rails db:migrate:redo STEP=1'
alias smig='skip_env mig'

alias unlog='gunzip `rg -g production.log -w`'
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
# Leiningen
alias l='lein'
alias repl='l repl'

# Adam
alias ran='clj -M:dev:nrepl'
alias rat='clj -M:test:runner --watch'

# Asuka
alias rw='npm run watch'
alias rwh='NERV_BASE=/nerv npm run watch'
alias rwc='NERV_BASE=/nerv_ck npm run watch'
alias rws='NERV_BASE=/nerv_sg npm run watch'

# Tmuxinator
alias t='tmuxinator'
alias work='t s work'
# alias wadam='t s work_adam'

########################
# Jump Into Config File
########################
alias dot='cd ~/dotfiles'
alias zshrc='e ~/.zshrc'
alias sozsh='source ~/.zshrc'
alias vimrc='e ~/.config/nvim/init.vim'
alias en='e .env'
alias mc='mailcatcher --http-ip 0.0.0.0 ; rse'
alias kmc='pkill -f mailcatcher'

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

export FZF_TMUX=1
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden'
# export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g '!{.git,.clj-kondo,node_modules}/*''

# module widget remap
export FZF_COMPLETION_TRIGGER=';'
bindkey '^r' fzf-history-widget
bindkey '^t' fzf-completion
bindkey '^F' autosuggest-accept
bindkey '^p' history-substring-search-up
bindkey '^n' history-substring-search-down

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
