#!/bin/bash

_prompt_git_branch() {
  branch=$(git symbolic-ref HEAD 2>/dev/null | awk -F/ '{print $NF}')
  [ -n "$branch" ] && echo "@$branch"
}

PS1='${PWD/$HOME/"~"}$(_prompt_git_branch|sed s/@/\[\e[01m\]@\[\033[0m\]/)\[\e[38;2;127;127;170m\]❯\[\033[00m\] '
