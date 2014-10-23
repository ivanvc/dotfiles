source /usr/local/opt/chruby/share/chruby/chruby.sh
source /usr/local/opt/chruby/share/chruby/auto.sh

save_function()
{
  local ORIG_FUNC="$(declare -f $1)"
  local NEWNAME_FUNC="$2${ORIG_FUNC#$1}"
  eval "$NEWNAME_FUNC"
}

save_function chruby old_chruby

chruby() {
  old_chruby $*
  PATH=$(echo $PATH | sed 's/\.\/bin://' | sed 's/\.\/vendor\/local\/bin://')
  echo $PATH
  PATH="./bin:./vendor/local/bin:$PATH"
  echo $PATH
}

chruby ruby-2.1.3
