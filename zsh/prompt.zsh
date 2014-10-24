export PS1='$(git_branch)[nitrous.io:%2~]%# '
export SPROMPT='zsh: correct %F{red}%R%f to %F{green}%r%f [nyae]? '
export RPROMPT='[%D{%L:%M:%S %p}]'
export TMOUT=1

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
