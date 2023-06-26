#!/bin/bash

ave() {
  [ -n "$AWS_VAULT" ] && unset AWS_VAULT
  eval $(aws-vault exec -d3h "$1" env | grep AWS_ | xargs -I{} echo export {})
}

unave() {
  eval $(env | grep AWS_ | xargs -I{} echo unset {})
}
