########################
# Zim
########################

# Remove older command from the history if a duplicate is to be added.
setopt HIST_IGNORE_ALL_DUPS

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
# reference: https://zimfw.sh/docs/install/
ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
  # Download zimfw script if missing.
  if (( ${+commands[curl]} )); then
    curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  else
    mkdir -p ${ZIM_HOME} && wget -nv -O ${ZIM_HOME}/zimfw.zsh https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  fi
fi

if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
  # Install missing modules, and update ${ZIM_HOME}/init.zsh if missing or outdated.
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

# this setting is also affect language in Vim
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8

export EDITOR='nvim'

# For pair
pairg() { ssh -t $1 ssh -o 'StrictHostKeyChecking=no' -o 'UserKnownHostsFile=/dev/null' -p $2 -t ${3:-vagrant}@localhost 'tmux attach' }
pairh() { ssh -S none -o 'ExitOnForwardFailure=yes' -R $2\:localhost:22 -t $1 'watch -en 10 who' }

# Use nvim
alias e='nvim'
alias vdiff='nvim -d'

alias cat='bat'

if type nvim > /dev/null 2>&1; then
  alias vim='nvim'
fi

alias sshc='e ~/.ssh/config'
alias sshc_p='e ~/.ssh/config.d/prod'
alias setup_tags='ctags -R'

alias grep='grep --color=auto'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias c='clear'
alias aq='ag -F'
alias px='ps aux'
alias ep='exit'
alias ag=rg
alias rh='fc -R'

export RIPGREP_CONFIG_PATH=~/.ripgreprc
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# Git
alias gs='git status'
alias gcom='git checkout master'
alias gRs='git remote show origin'
alias gRp='git remote show origin | grep patch'
alias gRf='git remote show origin | grep feature'
alias gbda='git branch --merged | egrep -v "(^\*|master|nerv_ck|nerv_sg)" | xargs git branch -d'
alias gbdda='git branch | egrep -v "(^\*|master|nerv_ck|nerv_sg)" | xargs git branch -D'
alias glg='git log --stat --max-count=10 --pretty=format:"${_git_log_medium_format}"'
alias gdd='gwd origin/master...'
alias goc='gco'
alias gddd='gwd origin/master...'
alias gdde='e `gddd --name-only --relative`'
alias gddm='tig origin/master..'
alias gdda='gdd clojure/projects/adam'
alias gdds='gdd clojure/projects/asuka'
alias gddc='gdd clojure/components'
alias gle='e `gcs --pretty=format: --name-only`'
alias gddn='gddd --name-only --relative | cat'
alias gwe='e `git diff --name-only --relative`'
alias gie='e `git diff --cached --name-only --relative`'
alias gbs='git branch | grep -v spring'
alias gbt='git checkout nerv_ck'
alias gff='git checkout -b $(git branch --show-current)-fork'
alias glcs='git rev-parse --short=12 HEAD'

alias lg='lazygit'
alias ld='lazydocker'

# JavaScript
alias nodejs=node

########################
# Project Related
########################
export DISABLE_SPRING=1
alias krpu='rpu kill'
alias pru='rpu'
alias spru='skip_mig_warn=1 rpu'

alias rss='RAILS_RELATIVE_URL_ROOT=/`basename $PWD` rails server'

alias aoc='j ~/proj/advent-of-code'

# Nerv Projects
alias ck='j ~/proj/nerv_ck'
alias hk='j ~/proj/nerv_hk'
alias sg='j ~/proj/nerv_sg'
alias amoeba='j ~/proj/amoeba'
alias angel='j ~/proj/angel'
alias adam='j clojure/projects/adam'
alias asuka='j clojure/projects/asuka'
alias obsi='j /Users/$(whoami)/Library/Mobile\ Documents/iCloud~md~obsidian/Documents/Main'

# Gems
alias be='bundle exec'
alias rse='RAILS_RELATIVE_URL_ROOT=/`basename $PWD` be sidekiq'
alias rsk='RAILS_RELATIVE_URL_ROOT=/`basename $PWD` be rake sneakers:run'
alias stopme='be spring stop'
alias copm='cop master...'
alias rake='be rake'

# be careful with the folder position
alias db_time='ll /tmp/(^amoeba|nerv)_*.custom'
if [[ -d ~/proj/vm ]]; then
  alias e_db='vim ~/proj/vm/user/db_mapping.yml'

  alias db_dump='~/proj/vm/scripts/db_dump.rb && ch_pw'
  alias adb_dump='PGPORT=15432 ~/proj/vm/scripts/db_dump.rb && ch_pw'
  alias dump_db='~/proj/vm/scripts/dump_db.zsh'
  alias ch_pw='be rails runner ~/proj/vm/scripts/nerv/change_passwords.rb'
  alias e_pw='vim ~/proj/vm/scripts/nerv/change_passwords.rb'
else
  echo "[Reminder] You need to clone vm project from Gitlab to get scripts for alias."
fi

if [[ -d ~/proj/wscripts ]]; then
  alias e_db='vim ~/proj/wscripts/db/db_mapping.yml'
  alias ch_pw='be rails runner ~/proj/wscripts/db/ch_pw.rb'
  alias e_pw='vim ~/proj/wscripts/db/ch_pw.rb'
fi

# Rails
alias rc='RAILS_RELATIVE_URL_ROOT=/`basename $PWD` be rails console'
alias rct='be rails console test'
alias rch="tail -f ~/.pry_history | grep -v 'exit'"

alias skip_env="SKIP_PATCHING_MIGRATION='skip_any_patching_related_migrations'"
alias mig='rails db:migrate'
alias migs='rails db:migrate:status'
alias roll='rails db:rollback'
alias rock!='rails db:migrate:redo STEP=1'
alias test_db_seed='rails db:seed RAILS_ENV=test'
alias smig='skip_env mig'
alias rgm='rails generate migration'

alias unlog='gunzip `rg -g production.log -w`'
alias olog='e log/development.log'
alias otlog='e log/test.log'
alias clog='cat /dev/null >! log/lograge_development.log && cat /dev/null >! log/development.log'
alias ctlog='cat /dev/null >! log/lograge_test.log && cat /dev/null >! log/test.log'

# Test
alias mi='rails test'
alias testba='rails test test/controllers test/concepts test/forms test/models'

# Amoeba
alias ku='[[ -f tmp/pids/unicorn.pid ]] && kill `cat tmp/pids/unicorn.pid`'

# Clojure
alias ccop='clj-kondo --lint src --config .clj-kondo/config.edn --cache false'
alias ccup='brew reinstall clj-kondo'

# Adam
alias ran='clj -M:dev:nrepl'
alias rat='clj -M:test:runner --watch'

# Asuka
alias rw='npm run watch'
alias rwh='NERV_BASE=/nerv_hk npm run watch'
alias rwc='NERV_BASE=/nerv_ck npm run watch'
alias rws='NERV_BASE=/nerv_sg npm run watch'

# Tmuxinator
alias t='tmuxinator'
alias work='t s work'
alias deploy='t s deploy'

# DevOps
alias dk='docker'
alias dco='docker compose'
alias dcn='docker container'
########################
# Jump Into Config File
########################
alias dot='j ~/dotfiles'
alias zshrc='e ~/dotfiles/zsh/.zshrc'
alias sozsh='source ~/.zshrc'
alias vimrc='e ~/dotfiles/nvim/.config/nvim/init.lua'
alias en='e .env'
# alias mc='mailcatcher --http-ip 0.0.0.0; rse'
# alias kmc='pkill -f mailcatcher'

########################
# eza
########################
alias ls='eza'
alias ll='eza -l -a'
alias tree='eza --tree'

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
# https://github.com/sharkdp/fd#integration-with-other-programs
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git --color=always'
export FZF_DEFAULT_OPTS="--ansi"

# module widget remap
export FZF_COMPLETION_TRIGGER=';'
bindkey '^r' fzf-history-widget
bindkey '^t' fzf-completion
bindkey '^F' autosuggest-accept
bindkey '^p' history-substring-search-up
bindkey '^n' history-substring-search-down

eval "$(zoxide init zsh --cmd j)"

# use localhost / nerv for postgres service running in docker
export PGHOST=localhost
export PGUSER=nerv

case `uname` in
  Darwin)
    export HOMEBREW_NO_AUTO_UPDATE=1 # https://docs.brew.sh/Manpage

    # only works in ZSH
    path=(
      /opt/homebrew/opt/git/share/git-core/contrib/diff-highlight
      /opt/homebrew/opt/libpq/bin
      $path
    )

    # enable ruby 2.7 deprecation warning
    # export RUBYOPT='-W:deprecated'
    export RUBYOPT=''

    # export CFLAGS="-Wno-error=implicit-function-declaration"
    # export optflags="-Wno-error=implicit-function-declaration"

    # setting for Ruby 2.5.9 installation
    # export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"

    # setting for Ruby 2.1.5 / 2.2.3 installation
    # export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.0)"

    listening() {
      if [ $# -eq 0 ]; then
        lsof -iTCP -sTCP:LISTEN -n -P
      elif [ $# -eq 1 ]; then
        lsof -iTCP -sTCP:LISTEN -n -P | grep -i --color $1
      else
        echo "Usage: listening [pattern]"
      fi
    }
  ;;
  Linux)
    alias grep='grep --color=auto'
  ;;
esac

function _cop_ruby() {
  local exts=('rb,thor,builder,jbuilder,pryrc')
  local excludes=':(top,exclude)db/schema.rb'
  local extra_options='--display-cop-names'

  if [[ $# -gt 0 ]]; then
    local files=$(eval "noglob git diff $@ --diff-filter=d --name-only -- *.{$exts} $excludes")
  else
    local files=$(eval "noglob git status --porcelain -- *.{$exts} $excludes | sed -e '/^\s\?[DRC] /d' -e 's/^.\{3\}//g'")
  fi

  if [[ -n "$files" ]]; then
    echo $files | xargs bundle exec rubocop `echo $extra_options` --format pacman
  else
    echo 'Nothing to check (rubocop).'
  fi
}

if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

  autoload -Uz compinit
  compinit
fi

# fix issue on puma start in deamon mode
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
