_prompt_git_branch() {
  branch=$(git symbolic-ref HEAD 2>/dev/null | awk -F/ '{print $NF}')
  [ ! -z "$branch" ] && printf "\e[1m\e[38;2;98;114;164m@\033[0m$branch"
}

PS1='${PWD/$HOME/"~"}$(_prompt_git_branch)\[\e[38;2;127;127;170m\]❯\[\033[00m\] '
