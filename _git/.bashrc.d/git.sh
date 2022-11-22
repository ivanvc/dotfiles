# Alias git to "g"
alias g=git

# Load autocomplete
if [ -f /usr/share/git/completion/git-completion.bash ] ; then
  source /usr/share/git/completion/git-completion.bash

  # And add autocomplete to the alias too
  ___git_complete g __git_main
fi
