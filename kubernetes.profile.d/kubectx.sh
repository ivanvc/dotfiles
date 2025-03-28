#!/bin/bash

# Ignore kubectx's fzf
export KUBECTX_IGNORE_FZF=1

alias kc=kubectx
alias kn=kubens

if command asdf &>/dev/null && asdf which kubectx &> /dev/null && [ -d "$(asdf where kubectx)"/completion ]; then
  for file in "$(asdf where kubectx)"/completion/*.bash; do
    # shellcheck source=/dev/null
    source "$file"
  done
  complete -F _kube_contexts kc
  complete -F _kube_namespaces kn
fi

if brew list kubectx &>/dev/null; then
  complete -F _kube_contexts kc
  complete -F _kube_namespaces kn
fi
