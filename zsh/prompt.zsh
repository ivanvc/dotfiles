function git_branch {
  echo $(/usr/bin/git symbolic-ref HEAD 2>/dev/null | awk -F/ {'print $NF'})
}

function rbenv_info {
  if which rbenv > /dev/null ; then
    rbenv version | cut -d' ' -f1
  fi
}

function zle-keymap-select {
  VIMODE="${${KEYMAP/vicmd/ M:command}/(main|viins)/}"
  zle reset-prompt
}
