set nocompatible                  " Must come first because it changes other options.

source ~/.config/nvim/plug.vim    " Source vim-plug from an external file
if !empty(globpath('~/', '.local.vim'))
  source ~/.local.vim
endif

set laststatus=2                  " Always display status bar

syntax enable                     " Turn on syntax highlighting.
filetype on                       " And now enable it
filetype indent on                " Enable specific indent.
filetype plugin indent on         " Turn on file type detection.

set showcmd                       " Display incomplete commands.
set showmode                      " Display the mode you're in.

set backspace=indent,eol,start    " Intuitive backspacing.

set hidden                        " Handle multiple buffers better.

set wildmenu                      " Enhanced command line completion.
set wildmode=list:longest         " Complete files like a shell.

set ignorecase                    " Case-insensitive searching.
set smartcase                     " But case-sensitive if expression contains a capital letter.

set number                        " Show line numbers.
set ruler                         " Show cursor position.
set ai                            " Auto indent

set incsearch                     " Highlight matches as you type.
set hlsearch                      " Highlight matches.

set wrap                          " Turn on line wrapping.
set scrolloff=3                   " Show 3 lines of context around the cursor.

set title                         " Set the terminal's title

set visualbell                    " No beeping.

set nobackup                      " Don't make a backup before overwriting a file.
set nowritebackup                 " And again.

set softtabstop=2
set tabstop=2                    " Global tab width.
set shiftwidth=2                 " And again, related.
set expandtab                    " Use spaces instead of tabs

set background=dark              " Dark background.
set cursorline                   " Hightlights the current line.
set colorcolumn=80               " Display 80 chars column.
set termguicolors                " Enable colors in terminal mode.
hi CursorLine ctermbg=black      " Change cursor line bg color.
if !has('nvim')
  set t_Co=256                   " Explicitly tell Vim that the terminal supports 256 colors
endif

" Display trailing white spaces
highlight ExtraWhitespace ctermbg=darkred guibg=red   " Set color
match ExtraWhitespace /\s\+\%#\@<!$/                  " Whitespace regex
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/ " Don't display in insert mode
au InsertLeave * match ExtraWhitespace /\s\+$/        " Display after exiting insert mode

" Tab mappings.
map <leader>tt :tabnew<cr>
map <leader>te :tabedit
map <leader>tc :tabclose<cr>
map <leader>to :tabonly<cr>
map <leader>tn :tabnext<cr>
map <leader>tp :tabprevious<cr>
map <leader>tf :tabfirst<cr>
map <leader>tl :tablast<cr>
map <leader>tm :tabmove

" Encoding
set encoding=utf8

" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>

" List chars
set listchars=""                  " reset the listchars
set listchars=tab:→\ ,eol:↲       " a tab should display as "→ ", end of lines as "↲"
set listchars+=trail:•            " show trailing spaces as bullets
set listchars+=extends:>          " the character to show in the last column when wrap is
                                  " off and the line continues beyond the right of the screen
set listchars+=precedes:<         " the character to show in the first column when wrap is
                                  " off and the line continues beyond the left of the screen
set listchars+=nbsp:␣             " the character to show for a non-breaking space
set list                          " turn on the list option

" _= and _$ functions, to remove trailing white spaces and re-indent.
function! Preserve(command)
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  execute a:command
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction
nmap <leader>$ :call Preserve("%s/\\s\\+$//e")<CR>
nmap <leader>= :call Preserve("normal gg=G")<CR>

" Wrap lines to N chars
function! Wordwrap(chars)
  exe 'setlocal textwidth='.a:chars
  execute "normal! \<S-v> }"
  execute "normal gq"
endfunction
nmap <leader>w :call Wordwrap(80)<cr>
nmap <leader>W :call Wordwrap(72)<cr>

" Terminal remappings
if has('nvim')
  " Exit with Esc/Ctrl+[
  tnoremap <Esc> <C-\><C-n>
  " Send Esc with Ctr+l[
  tnoremap <C-[> <Esc>

  " Open a new terminal in a window
  nmap <leader>wv :vsp term://$SHELL<cr>
  nmap <leader>ws :sp term://$SHELL<cr>
endif

" Ignore mouse
set mouse=
