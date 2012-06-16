# path
if [[ -d $HOME/.rbenv ]] || which rbenv > /dev/null ; then
  [[ -d $HOME/.rbenv/bin ]] && PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi

# rehash shims
rbenv rehash 2>/dev/null

# shell thing
rbenv() {
  command="$1"
  if [ "$#" -gt 0 ]; then
    shift
  fi

  case "$command" in
  shell)
    eval `rbenv "sh-$command" "$@"`;;
  *)
    command rbenv "$command" "$@";;
  esac
}
