if [ -d $HOME/.parts ] ; then
  export PATH=$HOME/.parts/autoparts/bin:$PATH
  eval "$(parts env)"
fi
