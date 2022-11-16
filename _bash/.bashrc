# If not running interactively, don't do anything
[[ $- != *i* ]] && return

for file in $HOME/.bashrc.d/*.sh; do
  [[ -e "$file" ]] && source "$file"
done

[[ -f "$HOME/.localrc" ]] && source "$HOME/.localrc"
