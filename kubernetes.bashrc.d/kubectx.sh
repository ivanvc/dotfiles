# Ignore kubectx's fzf
export KUBECTX_IGNORE_FZF=1

alias kc=kubectx
alias kn=kubens

if command asdf >/dev/null && [ -d `asdf where kubectx`/completion ]; then
  source `asdf where kubectx`/completion/*.bash
  complete -F _kube_contexts kc
  complete -F _kube_namespaces kn
fi
