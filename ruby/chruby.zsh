if [ -d /usr/local/opt/chruby ] ; then
  source /usr/local/opt/chruby/share/chruby/chruby.sh
  source /usr/local/opt/chruby/share/chruby/auto.sh
fi

save_function()
{
  local ORIG_FUNC="$(declare -f $1)"
  local NEWNAME_FUNC="$2${ORIG_FUNC#$1}"
  eval "$NEWNAME_FUNC"
}

if type chruby &>/dev/null; then
  save_function chruby old_chruby
fi

chruby() {
  old_chruby $*
  PATH=$(echo $PATH | sed 's/\.\/bin://' | sed 's/\.\/vendor\/local\/bin://')
  PATH="./bin:./vendor/local/bin:$PATH"
}
