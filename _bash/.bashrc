#!/bin/bash

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

for file in "$HOME"/.bashrc.d/*.sh; do
  # shellcheck source=/dev/null
  [[ -e "$file" ]] && source "$file"
done

# shellcheck source=/dev/null
[[ -f "$HOME"/.localrc ]] && source "$HOME"/.localrc
