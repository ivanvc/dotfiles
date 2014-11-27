if [ -f $HOME/.nitrousboxrc ] ; then
  export PS1='$(git_branch)[nitrous.io:%2~]%# '
else
  if [[ -n $SSH_CONNECTION ]]; then
    export PS1='$(git_branch)[%m:%2~]%# '
  else
    export PS1='$(git_branch)[%2~]%# '
  fi
fi

export SPROMPT='zsh: correct %F{red}%R%f to %F{green}%r%f [nyae]? '
export RPROMPT='[%D{%L:%M:%S %p}]'
export TMOUT=5

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
