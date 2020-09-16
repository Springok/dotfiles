########################
# Zplug
########################
### Added by Zinit's installer
# install zinit, if necessary
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

### End of Zinit's installer chunk

zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-history-substring-search
zinit light zdharma/fast-syntax-highlighting

zinit ice as="program" pick="$ZPFX/bin/(fzf|fzf-tmux)" \
  atclone="./install;cp bin/(fzf|fzf-tmux) $ZPFX/bin"
zinit light junegunn/fzf

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FZF_TMUX=1

# Load the pure theme, with zsh-async library that's bundled with it.
zinit ice pick"async.zsh" src"pure.zsh"
zinit light sindresorhus/pure

# need to install svn, `sudo apt-get install subversion`
# keep git after pure, don't know why
zinit ice svn
zinit snippet PZT::modules/git

zinit snippet PZT::modules/environment
zinit snippet PZT::modules/completion
zinit snippet PZT::modules/history
zinit snippet PZT::modules/rsync
zinit snippet PZT::modules/directory

zinit snippet PZT::modules/ssh
zstyle ':prezto:module:ssh:load' identities 'id_rsa' 'id_ed25519'

zinit ice pick'bin/*.zsh'
zinit light 'bootleq/zsh-cop'
########################
# General
########################

source ~/.zshrc_helper

[ -f ~/.ssh/abagile-dev.pem ] && ssh-add ~/.ssh/abagile-dev.pem 2&> /dev/null

# Disable flow control then we can use ctrl-s to save in vim
# Disable flow control commands (keeps C-s from freezing everything)
stty start undef
stty stop undef

# asdf setting
. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash

# User configuration
export PATH=$HOME/bin:/usr/local/bin:$PATH

# this setting is also affect language in Vim
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8

# For pair
pairg() { ssh -t $1 ssh -o 'StrictHostKeyChecking=no' -o 'UserKnownHostsFile=/dev/null' -p $2 -t vagrant@localhost 'tmux attach' }
pairh() { ssh -S none -o 'ExitOnForwardFailure=yes' -R $2\:localhost:22222 -t $1 'watch -en 10 who' }

# Use nvim
alias e='nvim'
alias vdiff='nvim -d'

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
alias gdde='e `gddd --name-only --relative`'
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

# export USE_BOOTSNAP=1
alias krpu='rpu kill'
alias pru='rpu'

# Npm
alias n='npm'
alias nw='npm run watch'
alias fight='API_URL="/`basename $PWD`" nw'
alias eva_fight='eva ; fight'

# Yarn
alias ys='yarn start'
alias yf="yarn prettier --config .prettierrc --write 'src/**/*.{js,jsx,json,css,scss,md}'"
alias yt='yarn test'
alias ycop='yarn eslint --fix-dry-run src/'

# Nerv Projects
alias ck='cd ~/nerv_ck'
alias hk='cd ~/nerv'
alias ka='cd ~/nerv_asuka'
alias eva='cd eva/asuka'
alias agl='cd ~/angel'
alias ame='cd ~/amoeba'
alias adm='cd ~/nerv/clojure/adam'

alias ch_pw='rails runner /vagrant/synced/ch_pw.rb'
alias e_pw='vim /vagrant/synced/ch_pw.rb'
alias dump_db='/vagrant/scripts/db_dump.rb -f && ch_pw'
alias dump_db2='/vagrant/scripts/dump_db.zsh'
alias cd_sync='cd /vagrant/synced/'

# remote dev machine
# alias ch_pw='rails runner ~/synced/ch_pw.rb'
# alias e_pw='vim ~/synced/ch_pw.rb'
# alias dump_db3='~/vm/scripts/db_dump.rb -f && ch_pw'

# Gems
alias be='bundle exec'
alias seki='be sidekiq'
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

alias unlog='gunzip `ag -g production.log -w`'
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

########################
# Jump Into Config File
########################
alias dot='cd ~/dotfiles'
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
export FZF_COMPLETION_TRIGGER=';'
bindkey '^r' fzf-history-widget
bindkey '^t' fzf-completion
bindkey '^F' autosuggest-accept
bindkey '^p' history-substring-search-up
bindkey '^n' history-substring-search-down
