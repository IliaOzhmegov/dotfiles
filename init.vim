call plug#begin()
    Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
	Plug 'SirVer/ultisnips'
	Plug 'honza/vim-snippets'
	Plug 'scrooloose/nerdtree'
    Plug 'tpope/vim-surround'
    Plug 'bling/vim-airline'
    Plug 'scrooloose/nerdcommenter'
    Plug 'morhetz/gruvbox'
    Plug 'lervag/vimtex'
call plug#end()



" basics
filetype plugin indent on
syntax on 
set number
set relativenumber
set incsearch
set ignorecase
set smartcase
set nohlsearch
set tabstop=4
set softtabstop=0
set shiftwidth=4
set expandtab
set nobackup
set noswapfile
set nowrap


" clipboard settings
set clipboard+=unnamedplus

" colourscheme
colorscheme gruvbox

" NERDtree setting
map <C-n> :NERDTreeToggle<CR>

" preferences
tnoremap <Esc> <C-\><C-n>
let g:loaded_python3_provider=1
let mapleader = ","
set pastetoggle=<F2>
setlocal spell spelllang=ru_yo,en_us
" j/k will move virtual lines (lines that wrap)
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

" navigate split screens easily
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>

" Theme
syntax enable

" language 
set keymap=russian-jcukenwin
set iminsert=0 " Чтобы при старте ввод был на английском, а не русском (start > i)
set imsearch=0 " Чтобы при старте поиск был на английском, а не русском (start > /)

"" latex preferences
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg'
let g:vimtex_compiler_progname='nvr'     

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

