# dotfiles

As I was setting up once again a new computer, I just
noticed how bloated my dotfiles were. I had two branches
the main one for MacOS (which I don't use anymore), and
a linux one. I based my directory structure on Zach
Holman's, having them by topic. Then, I wrote a bash script
to symlink the files. I recently just realized that GNU
Stow can be used to do this step. So, this time I'm starting
from scratch. Deleting all the old files, and managing them
using stow.
