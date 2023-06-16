" Ensure vim-plug is installed
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins
call plug#begin()
Plug 'dracula/vim'

Plug 'itchyny/lightline.vim'

Plug 'fatih/vim-go', {'do': ':GoUpdateBinaries'}
Plug 'plasticboy/vim-markdown'
Plug 'hashivim/vim-terraform'
Plug 'mustache/vim-mustache-handlebars'
Plug 'google/vim-jsonnet'

Plug 'tpope/vim-fugitive'
Plug 'jamessan/vim-gnupg'
Plug 'fcpg/vim-waikiki'

Plug 'junegunn/vim-emoji'

Plug 'dyng/ctrlsf.vim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'cohama/lexima.vim' " autoclose parenthesis
call plug#end()

" Colorscheme
colorscheme dracula

" Lightline
let g:lightline = { 'colorscheme': 'dracula' }

" Markdown
let g:vim_markdown_folding_disabled = 1         " Don't autofold
autocmd FileType markdown setl conceallevel=2
autocmd FileType markdown setl concealcursor=""

" Emoji
set completefunc=emoji#complete
function! ReplaceEmoji()
  let curr_line   = getline('.')
  let replacement = substitute(curr_line, ':\([^:]\+\):', '\=emoji#for(submatch(1), submatch(0))', 'g')
  call setline('.', replacement)
endfunction
map <leader>emo :call ReplaceEmoji()<cr>

" Waikiki
let maplocalleader = "\\"
let g:waikiki_roots = ['~/Documents/Wiki']
let g:waikiki_default_maps = 1
let g:waikiki_conceal_markdown_url = 1
map <leader>ww :e ~/Documents/Wiki/index.md<cr>
function! WaikikiSetupBuffer() abort
  setl concealcursor=""
endfun
augroup Waikiki
  au!
  autocmd User setup
        \ call WaikikiSetupBuffer()
augroup END

" Telescope
nnoremap <leader>t <cmd>Telescope find_files<cr> "Open file finder

" Auto format terraform files
let g:terraform_fmt_on_save = 1
