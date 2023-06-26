# Set data directory to ~/.local/share
export ASDF_DATA_DIR=$HOME/.local/share/asdf

# Initialize asdf
if [ -f /opt/asdf-vm/asdf.sh ]; then
  . /opt/asdf-vm/asdf.sh
fi

if [ -f /usr/local/opt/asdf/libexec/asdf.sh ]; then
  . /usr/local/opt/asdf/libexec/asdf.sh
fi
