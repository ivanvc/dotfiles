. $ZSH/z/rupa-z/z.sh
function precmd () {
  _z --add "$(pwd -P)"
}
