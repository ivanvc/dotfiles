# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=always'

for file in $HOME/.bash.*.sh; do
  [ -e "$file" ] && source $file
done
