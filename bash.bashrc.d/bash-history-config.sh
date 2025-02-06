#!/bin/bash

# History commands (!) won't execute the first time you hit enter.
shopt -s histverify

# When the shell exits, append to the history file instead of overwriting it
shopt -s histappend

# Avoid duplicates, ignore commands that start with space
export HISTCONTROL=erasedups:ignoreboth

# After each command, append to the history file and reread it
PROMPT_COMMAND="history -a;history -c;history -r;${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}"

# Unlimited history
export HISTFILESIZE=-1
export HISTSIZE=-1

# Add timestamp to history
export HISTTIMEFORMAT="[%F %T] "

# Change history file to a different file to avoid truncation from other
# instances of bash that may read or write it.
export HISTFILE=~/.bash_eternal_history
