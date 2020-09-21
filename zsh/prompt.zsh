if [[ -n $SSH_CONNECTION ]]; then
  export PS1='$(git_branch)%F{111}[%f%m:%2~%F{111}]%f%# '
else
  export PS1='%F{4}[%f$(due_tasks)$(git_branch)%2~%F{4}]%#%f '
fi

export SPROMPT='zsh: correct %F{red}%R%f to %F{green}%r%f [nyae]? '
#export RPROMPT='[%D{%L:%M:%S %p}]'
export TMOUT=20

TRAPALRM() {
  zle reset-prompt
}

function git_branch {
  b=$(/usr/bin/git symbolic-ref HEAD 2>/dev/null | awk -F/ {'print $NF'})
  if [ ! -z $b ] ; then
    echo "%F{12}$b%F{4}:%f"
  fi
}

function due_tasks {
  if (which task > /dev/null 2>&1) && [ -f "$HOME/.taskrc" ] ; then
    local tasks=$(task '(due.before:today or due:today) and status:pending' count)
    [ $tasks -gt 0 ] && echo "%F{9}$tasks%F{4}ǀ%f" && return
    tasks=$(task '(due.after:today) and status:pending' count)
    [ $tasks -gt 0 ] && echo "%F{11}$tasks%F{4}ǀ%f" && return
    tasks=$(task 'status:pending' count)
    [ $tasks -gt 0 ] && echo "%F{8}$tasks%F{4}ǀ%f" && return
  fi
}

function zle-keymap-select {
  VIMODE="${${KEYMAP/vicmd/ M:command}/(main|viins)/}"
  zle reset-prompt
}

function aws_account_info {
  [ "$AWS_ACCOUNT_NAME" ] && [ "$AWS_ACCOUNT_ROLE" ] && echo "> aws: \033[1m$AWS_ACCOUNT_ROLE@$AWS_ACCOUNT_NAME\033[0m"
}

function precmd {
  p="$(aws_account_info)"
  if [ ! -z $p ] ; then
    print "$p"
  fi
}
