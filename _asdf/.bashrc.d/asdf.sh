#!/bin/bash

# Set data directory to ~/.local/share
export ASDF_DATA_DIR=$HOME/.local/share/asdf

# Initialize asdf
__initialize_asdf() {
  local files="/opt/asdf-vm/asdf.sh /usr/local/opt/asdf/libexec/asdf.sh /home/linuxbrew/.linuxbrew/opt/asdf/libexec/asdf.sh"
  for file in $files; do
    if [ -f "$file" ]; then
      # shellcheck source=/dev/null
      . "$file"
    fi
  done
}

__initialize_asdf
