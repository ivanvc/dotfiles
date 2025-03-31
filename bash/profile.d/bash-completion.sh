#!/usr/bin/env bash

if [ -r /home/linuxbrew/.linuxbrew/etc/profile.d/bash_completion.sh ]; then
  # shellcheck disable=SC1091
  # disable linting the sourced file.
  . /home/linuxbrew/.linuxbrew/etc/profile.d/bash_completion.sh
fi
