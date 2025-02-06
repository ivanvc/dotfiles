#!/bin/bash

# Edit and execute with Ctrl-x Ctrk-e
bind -m vi-insert '"\C-x\C-e":edit-and-execute-command'

# Fix vi mode unix-word-rubout
stty werase undef
