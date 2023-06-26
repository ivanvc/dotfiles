#!/bin/bash

# Alias k to kubectl
alias k=kubectl

# Load completion
if command kubectl &> /dev/null; then
  source <(kubectl completion bash)
  # Auto complete for the k alias too
  complete -o default -F __start_kubectl k
fi
