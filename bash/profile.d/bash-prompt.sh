#!/bin/bash

_prompt_git_branch() {
  branch=$(git symbolic-ref HEAD 2>/dev/null | awk -F/ '{print $NF}')
  commit=$(git rev-parse HEAD 2>/dev/null | awk '{print substr($0,1,7)}')
  if [ -n "$branch" ]; then
    echo "@$branch"
  elif [ -n "$commit" ]; then
    echo "#$commit"
  fi
}

PS1='${PWD/$HOME/"~"}$(_prompt_git_branch|sed -r "s/(@|#)/\[\e[01m\]\1\[\033[0m\]/")\[\e[38;2;127;127;170m\]❯\[\033[00m\] '
