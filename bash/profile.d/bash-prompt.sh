#!/usr/bin/env bash

_prompt_git_branch() {
  branch=$(git symbolic-ref HEAD 2>/dev/null | awk -F/ '{print $NF}')
  commit=$(git rev-parse HEAD 2>/dev/null | awk '{print substr($0,1,7)}')
  if [ -n "$branch" ]; then
    printf "\e[01m@\033[0m$branch"
  elif [ -n "$commit" ]; then
    printf "\e[01m#\033[0m$commit"
  fi
}

_prompt() {
  local exit_code=$?
  if [ -z "${COPY_MODE+x}" ]; then
    if [ "$exit_code" -eq 0 ]; then
      printf "${PWD/$HOME/"~"}$(_prompt_git_branch)\e[38;2;127;127;170m❯\033[0m"
    else
      printf "${PWD/$HOME/"~"}$(_prompt_git_branch)\e[1;35;170m❯\033[0m"
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
