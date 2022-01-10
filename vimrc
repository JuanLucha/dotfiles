" File encoding to utf-8
set encoding=utf-8
set fileencodings=utf-8

set bs=indent,eol,start		" allow backspacing over everything in insert mode
set viminfo='20,\"50	" read/write a .viminfo file, don't store more than 50 lines of registers
set ruler		" show the cursor position all the time

" Cursor from block to pipe
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif
:autocmd InsertEnter * set cul
:autocmd InsertLeave * set nocul

" Rebind <Leader> key
let mapleader = ","

" bind Ctrl+<movement> keys to move around the windows, instead of using Ctrl+w + <movement>
map <c-j> <c-w>j
map <c-k> <c-W>k
map <c-l> <c-w>l
map <c-h> <c-w>h
map <Leader>d <c-w>w

" Easier moving between tabs
map <S-h> <esc>:tabprevious<CR>
map <S-l> <esc>:tabnext<CR>

" State management
map <leader>w :wa<CR>
map <leader>q :xa<CR>

" Status line
set statusline=%F%m%r%h%w[%L][%{&ff}]%y[%p%%][%04l,%04v]

" Make Silver Searcher not search in filenames
command! -bang -nargs=+ -complete=dir Rag 
        \ call fzf#vim#ag_raw(<q-args> . ' ~/Documents/Projects/',
        \ fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}), <bang>0)

" Show whitespace
" MUST be inserted BEFORE the colorscheme command
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
au InsertLeave * match ExtraWhitespace /\s\+$/
colo slate

" Enable syntax highlighting
" You need to reload this file for the change to apply
set nocompatible
filetype on
filetype plugin on
filetype indent on
syntax on

" Showing line numbers and length
set number	" show line numbers
set tw=120	" width of document (used by gd)
set nowrap	" don't automatically wrap on load
set fo-=t	" don't automatically wrap text when typing

" Useful settings
set history=700
set undolevels=700

" Real programmers don't use TABs but spaces
set tabstop=2
set softtabstop=2
set shiftwidth=2
set shiftround
set expandtab

" Make search case insensitive
set hlsearch
set incsearch
set ignorecase
set smartcase

" Remap the space to / to search faster
map <Space> /

" Disable stupid backup and swap files - they trigger too many events for file system watchers
set nobackup
set nowritebackup
set noswapfile

" Color scheme
syntax enable

" Set the ESC key to fj
inoremap fj <Esc>

" To remap page up and down
noremap <S-j> <C-d>
noremap <S-k> <C-u>

" Maximum number of characters per line with indicator
highlight ColorColumn ctermbg=0
if exists('+colorcolumn')
  set colorcolumn=120
else
    au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>120v.\+', -1)
endif

" Relative number toggle
set relativenumber
set number

" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

  " Make sure you use single quotes
  Plug 'preservim/nerdtree'

  " Comments
  Plug 'https://github.com/tpope/vim-commentary'

  " Fuzzy finder
  Plug 'https://github.com/kien/ctrlp.vim'

  " File search (requires Silver Searcher: https://github.com/ggreer/the_silver_searcher and
  " Bat: https://github.com/sharkdp/bat)
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'

  " Syntax Highlighters
  Plug 'https://github.com/pangloss/vim-javascript'
  Plug 'https://github.com/leafgarland/typescript-vim'

  " Easymotion
  Plug 'easymotion/vim-easymotion'

  " Prettier, with post install (yarn install | npm install) then load plugin only for editing supported files
  Plug 'prettier/vim-prettier', { 'do': 'yarn install --frozen-lockfile --production' }

  " Autosave
  Plug 'https://github.com/907th/vim-auto-save'

" Initialize plugin system
call plug#end()

" Fuzzy finder ignore
let g:ctrlp_custom_ignore = 'node_modules\|git\|hg\|svn'

" NerdTREE
nnoremap <leader>e :NERDTreeToggle<CR>
nnoremap <leader>f :NERDTreeFind<CR>

" Prettier config
let g:prettier#autoformat_config_present = 1
let g:prettier#autoformat_require_pragma = 0
let g:prettier#exec_cmd_async = 1

" Autosave
let g:auto_save = 1

