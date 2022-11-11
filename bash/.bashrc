# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'

if [ -f $HOME/.bash.*.sh ]; then
  for file in $HOME/.bash.*.sh; do source $file; done
fi
