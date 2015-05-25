# History settings

# Allow use to re-edit a faild history substitution.
shopt -s histreedit
# History expansions will be verified before execution.
shopt -s histverify
# Enable sudo tab completion
complete -cf sudo

# Entries beginning with space aren't added into history, and duplicate
# entries will be erased (leaving the most recent entry).
export HISTCONTROL="ignorespace:erasedups:ignoreboth"
# leave some commands out of history log
export HISTIGNORE='&:??:[ ]*:clear:exit:logout'
# Give history timestamps.
export TIMEFORMAT=$'\nreal %3R\tuser %3U\tsys %3S\tpcpu %P\n'
export HISTTIMEFORMAT="[%F %T] "
# Lots o' history.
export HISTSIZE=10000
export HISTFILESIZE=10000

# Easily re-execute the last history command.
alias r="fc -s"
