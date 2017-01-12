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
plugins=(git zsh-autosuggestions)

# disable flow control for vim ctrl-s save
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

alias clog='cat /dev/null > log/development.log'

alias rc='bin/rails console'
alias skip_env="SKIP_PATCHING_MIGRATION='skip_any_patching_related_migrations'"
alias mig='bin/rake db:migrate'
alias migs='bin/rake db:migrate:status'
alias vim ='vim'
alias roll='bin/rake db:rollback'
alias rock!='roll && mig'
alias smig='skip_env mig'

alias tm='tmux attach || tmux new'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias c='clear'
alias aq='ag -Q'

alias ku='[[ -f tmp/pids/unicorn.pid ]] && kill `cat tmp/pids/unicorn.pid`'
alias pukill='bundle exec pumactl -P /home/vagrant/nerv/tmp/pids/puma.pid stop'
alias pukill2='bundle exec pumactl -P /home/vagrant/nerv2/tmp/pids/puma.pid stop'
alias punerv='RAILS_RELATIVE_URL_ROOT=/nerv bundle exec puma -d -C config/puma.rb config.ru'
alias punerv2='RAILS_RELATIVE_URL_ROOT=/nerv2 bundle exec puma -d -C config/puma.rb config.ru'
alias pupry='RAILS_RELATIVE_URL_ROOT=/nerv bundle exec puma -C config/puma.rb config.ru'
alias pupry2='RAILS_RELATIVE_URL_ROOT=/nerv2 bundle exec puma -C config/puma.rb config.ru'

alias seki='be sidekiq'
alias stopme='be spring stop'
alias rubo='be rubocop'
alias rake='be rake'

alias gcon='vim ~/.gitconfig'
alias sozsh='source ~/.zshrc'
alias zshrc='vim ~/.zshrc'
alias vimrc='vim ~/.vimrc.local'
alias en='vim .env'

alias vt='vim -c :CtrlP'

alias nerv='cd ~/nerv'
alias nerv2='cd ~/nerv2'
alias va='cd /vagrant'

alias dump_db='~/helper/dumpdb.sh'

alias be='bundle exec'

alias mi='be ruby -Itest'
alias mii='rake test'
alias testba='rake test:concepts && rake test:forms && rake test:models'

alias gl='git log'
alias gdn='git diff --no-ext-diff --word-diff'

# You may need to manually set your language environment
export LANG=en_US.UTF-8

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
