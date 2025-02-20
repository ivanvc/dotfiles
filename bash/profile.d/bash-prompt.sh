#!/usr/bin/env bash

_prompt_git_branch() {
  branch=$(git symbolic-ref HEAD 2>/dev/null | awk -F/ '{print $NF}')
  commit=$(git rev-parse HEAD 2>/dev/null | awk '{print substr($0,1,7)}')
  if [ -n "$branch" ]; then
    printf "\001\033[01\002m@\001\033[0m\002$branch"
  elif [ -n "$commit" ]; then
    printf "\001\033[01m\002#\001\033[0m\002$commit"
  fi
}

_prompt() {
  local exit_code=$?
  if [ -z "${COPY_MODE+x}" ]; then
    if [ "$exit_code" -eq 0 ]; then
      echo -ne "${PWD/$HOME/"~"}$(_prompt_git_branch)\001\033[38;2;127;127;170m\002❯\001\033[m\002"
    else
      echo -ne "${PWD/$HOME/"~"}$(_prompt_git_branch)\001\033[1;34m\002❯\001\033[m\002"
    fi
  else
    printf "\$"
  fi
}

cm() {
  if [ -z "${COPY_MODE+x}" ]; then
    export COPY_MODE=1
  else
    unset COPY_MODE
    export COPY_MODE
  fi
}

PS1='$(_prompt) '
