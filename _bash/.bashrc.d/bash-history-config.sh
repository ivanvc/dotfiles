# History commands (!) won't execute the first time you hit enter.
shopt -s histverify

# When the shell exits, append to the history file instead of overwriting it
shopt -s histappend

# Avoid duplicates, ignore commands that start with space
HISTCONTROL=erasedups:ignoreboth

# After each command, append to the history file and reread it
PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"

# Unlimited history
HISTFILESIZE=
HISTSIZE=
