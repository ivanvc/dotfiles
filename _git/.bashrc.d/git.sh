# Alias git to "g"
alias g=git

# Load autocomplete
__load_git_autocomplete() {
  local files="/Applications/Xcode.app/Contents/Developer/usr/share/git-core/git-completion.bash /usr/share/git/completion/git-completion.bash"
  for file in $files; do
    if [ -f "$file" ] ; then
      # shellcheck source=/dev/null
      . "$file"
      # And add autocomplete to the alias too
      ___git_complete g __git_main
    fi
  done
}

__load_git_autocomplete
