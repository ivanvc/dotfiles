# ~/.

Dotfiles à la Ivan.

## Irrelevant background

> As I was setting up a new computer again, I just noticed how bloated my
dotfiles were. I had two branches, the main one for MacOS (which I don't use
anymore) and a Linux one. I based my directory structure on Zach Holman's,
having them by topic. Then, I wrote a bash script to symlink the files. I
recently just realized that GNU Stow can do this step. So, this time I'm
starting from scratch. Deleting all the old files and managing them using a
Makefile and Stow.

After 10+ years of using Zsh as my shell, I returned ye good old Bash. The only
thing I miss is an excellent shared history across sessions. I never used Oh My
Zsh or any other frameworks, so my usage was pretty basic.

## Requirements

1. `make`
2. `stow`

## Project directory layout

There are three different types of directories in the root of the repository:

1. Directories that start with an underscore (i.e., `_bash`): These directories
   contain files that are symlink at the root directory (`~/`) of the user
   as-is. Therefore, the files inside are actual dotfiles (so watch out for
   those hidden guys!).
2. Directories that don't start with an underscore (i.e., `nvim`): These
   directories are symlinked in `$XDG_CONFIG_HOME` (`~/.config/`). In this case,
   the files are not hidden (yay!)
3. Directories that end with `bashrc.d` (i.e., `direnv.bashrc.d`): These
   directories contain files that will symlink at `~/.bashrc.d/`. Although this
   directory is not a standard, I'm just placing anything that needs to be
   initialized after Bash here (and these files are not hidden either, yay!)

## How to use

1. Run `make`, which will symlink all directories [^1]
2. There's no step 2 [^2]

## License

Not sure why someone would license their dotfiles, so I guess the best license
to fit here would be [WTFPL](http://www.wtfpl.net/txt/copying/).

[^1]: Unless you want to symlink a single repository, in that case run `make`
[^2]: Unless you want to uninstall, in that case just run `make uninstall`,
      or `STOW_COMMAND -D make ` to unstow a single directory
