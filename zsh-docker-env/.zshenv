# Start configuration added by Zim install {{{
#
# User configuration sourced by all invocations of the shell
#

# Define Zim location
: ${ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim}
# }}} End configuration added by Zim install

alias skip_env="SKIP_PATCHING_MIGRATION='skip_any_patching_related_migrations'"
alias mig='rails db:migrate'
alias smig='skip_env mig'
