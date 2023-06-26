#!/bin/bash

# Set default application for directories:
# xdg-mime default org.gnome.Nautilus.desktop inode/directory

function open {
  xdg-open $@ 2> /dev/null
}
