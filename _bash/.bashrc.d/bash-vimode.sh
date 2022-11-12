# Set vi mode
set -o vi

# But still, use emacs keys to move around
bind -m vi-insert '"\C-x\C-e":edit-and-execute-command'

stty werase undef
bind '\C-w':unix-word-rubout
