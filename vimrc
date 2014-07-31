call pathogen#infect()
call pathogen#helptags()

set nocompatible
set hidden
set history=1000
set wildmenu
set wildmode=list:longest
set ignorecase
set smartcase
set ruler
set hlsearch
set incsearch
set tags=tags;/
set number
set tabstop=2
set shiftwidth=2
set expandtab
set list
set listchars=tab:»\ ,trail:·
set autochdir
set backspace=indent,eol,start

" custom key mappings
let mapleader = ","
noremap \ ,
noremap <C-l> :nohlsearch<CR><C-l>

" Solarized color scheme
syntax on
set background=dark
let g:solarized_termtrans = 1
colorscheme solarized

" NERDTree settings
map <Leader>t :NERDTreeToggle<CR>
let NERDTreeShowBookmarks=1
" quit vim if NERDTree is the last thing open
autocmd bufenter * if (winnr("$") == 1 &&
                     \ exists("b:NERDTreeType") &&
                     \ b:NERDTreeType == "primary")
                   \ | q | endif

" CtrlP settings
let g:ctrlp_cmd = 'CtrlPMRUFiles'
" CtrlP should search from the current file's directory
let g:ctrlp_working_path_mode = 1

" yankstack settings
let g:yankstack_map_keys = 0 " our mappings only
nmap <leader>p <Plug>yankstack_substitute_older_paste
nmap <leader>P <Plug>yankstack_substitute_newer_paste

" Syntax highlighting
syntax on
filetype on
filetype plugin on
filetype indent on

" Store all backup files centrally
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

let big_grep="/home/engshare/admin/scripts/vim/biggrep.vim"
if filereadable(expand(big_grep))
  exec 'source' big_grep
endif

" vim settings for python
au Filetype python setl et ts=4 sw=4

