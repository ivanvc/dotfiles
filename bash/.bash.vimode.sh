# Set vi mode
set -o vi

# But still, use emacs keys to move around
bind '\C-a':beginning-of-line
bind '\C-b':backward-char
bind '\C-e':end-of-line
bind '\C-f':forward-char
bind '\C-x\C-e':edit-and-execute-command
