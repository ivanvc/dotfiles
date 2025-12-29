#!/usr/bin/env bash

__prompt_git_branch() {
  local branch
  local commit
  branch=$(git symbolic-ref HEAD 2>/dev/null | awk -F/ '{print $NF}')
  commit=$(git rev-parse HEAD 2>/dev/null | awk '{print substr($0,1,7)}')

  if [ -n "$branch" ]; then
    printf "\001\033[01m\002@\001\033[0m\002%s" "$branch"
  elif [ -n "$commit" ]; then
    printf "\001\033[01m\002#\001\033[0m\002%s" "$commit"
  fi
}

__prompt_command() {
  if [ -z "${COPY_MODE+x}" ]; then
    local job_count
    job_count=$(jobs -s | wc -l | tr -d 0 | xargs)
    if [ -n "$job_count" ]; then
      job_count="\001\033[0;34m\002▐\001\033[3;34m\002${job_count}\001\033[0;34m\002▌\001\033[m\002"
    fi
    local exit_code=$?
    local exit_code_color="\001\033[38;2;127;127;170m\002"
    if [ "$exit_code" -ne 0 ]; then
      exit_code_color="\001\033[1;34m\002"
    fi
    PS1=$(printf "%s%s%s%s❯\001\033[m\002 " "${job_count}" "${PWD/$HOME/"~"}" "$(__prompt_git_branch)" "$exit_code_color")
  else
    PS1='$ '
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


PROMPT_COMMAND="__prompt_command;${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}"
