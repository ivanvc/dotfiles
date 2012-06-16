[[ -d $HOME/.homebrew ]] && export PATH="$HOME/.homebrew/bin:$PATH"

if which brew > /dev/null ; then
  export PATH=`brew --prefix`/bin:`brew --prefix`/sbin:$PATH
  export MANPATH=`brew --prefix`/share/man:$MANPATH
fi
