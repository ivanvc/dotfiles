#!/bin/bash

ave() {
  local account="$1"
  shift
  local duration="$1"
  [ -z "$duration" ] && duration=3h

  [ -n "$AWS_VAULT" ] && unset AWS_VAULT
  eval "$(aws-vault exec -d"$duration" "$account" env | grep AWS_ | xargs -I{} echo export {})"
}

unave() {
  eval "$(env | grep AWS_ | xargs -I{} echo unset {})"
}
