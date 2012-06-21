git_branch() {
  echo $(/usr/bin/git symbolic-ref HEAD 2>/dev/null | awk -F/ {'print $NF'})
}

rbenv_info() {
  if which rbenv > /dev/null ; then
    rbenv version | sed 's/\([^ ]*\).*/\1/'
  fi
}
