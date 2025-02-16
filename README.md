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

### Iteration 3.5

I still like the thematic directories, and I still don't like the hidden
file in this repository. So, it was time for a new iteration on the previous
iteration as I started splitting directories into multiple directories to avoid
hidden files. Long story short, keep reading on.

## Requirements

1. `make`
2. `stow`

## Project directory layout

There are four different types of directories in the root of the repository:

1. Directories that have a `.config` suffix (i.e., `beets.config`): These
   directories will be symlinked at
   `~/.config/<directory name without .config suffix>`.
2. Directories that have a `.bin` suffix (i.e., `something.bin`): These
   directories will be symlinked at `~/.local/bin`, which is at the front of
   `$PATH`.
3. Directories that have a `.profile.d` suffix (i.e., `aws.profile.d`): These
   directories contain files that will be symlinked at `~/.config/profile.d`,
   which will be source by `~/.bashrc`.
4. Directories with no suffix. These can have:
    1. A `bin` directory, these files will be symlinked at `~/.local/bin`.
    2. A `config` directory, this directory will be symlinked at
       `~/.config/<directory name>`, i.e. `~/.config/nvim` for `nvim/config`.
    3. A `profile.d` directory, the files in this directory will be symlinked at
       `~/.config/profile.d`.
    4. Files and directories that start with a underscore (`_`), will be
       symlinked at the `$HOME` level replacing the first `_` with a `.`, i.e.,
       `_bashrc` will be symlinked at `~/.bashrc`

## How to use

1. Run `make`, which will symlink all directories [^1]
2. There's no step 2 [^2]

### Bonus: unversioned local file

If `~/.localrc` exists, Bash will source the file at the end of loading the rest
of the files. So, this is a good place for overrides for a specific computer.
Also, this file is not versioned, so it's also an ideal place to store secrets.

## License

Not sure why someone would license their dotfiles, so I guess the best license
to fit here would be [WTFPL](http://www.wtfpl.net/txt/copying/).

[^1]: Unless you want to symlink a single repository, in that case run
      `make <directory>`
[^2]: Unless you want to uninstall, in that case just run `make uninstall`, or
      `STOW_COMMAND=-D make <directory>` to unstow a single directory
