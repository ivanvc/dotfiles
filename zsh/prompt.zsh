if [[ -n $SSH_CONNECTION ]]; then
  export PS1='$(git_branch)[%m:%2~]%# '
else
  export PS1='$(git_branch)[%2~]%# '
fi

export SPROMPT='zsh: correct %F{red}%R%f to %F{green}%r%f [nyae]? '
export RPROMPT='[%D{%L:%M:%S %p}]'
export TMOUT=20

TRAPALRM() {
  zle reset-prompt
}

function git_branch {
  echo $(/usr/bin/git symbolic-ref HEAD 2>/dev/null | awk -F/ {'print $NF'})
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
