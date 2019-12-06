call plug#begin(stdpath('data') . '/plugged')

Plug 'arcticicestudio/nord-vim'

Plug 'airblade/vim-gitgutter'

Plug 'scrooloose/nerdTree'
Plug 'junegunn/fzf.vim'
Plug 'dense-analysis/ale'

Plug 'machakann/vim-highlightedyank'

Plug 'fatih/vim-go'

Plug 'vim-airline/vim-airline'

Plug 'Shougo/echodoc.vim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

call plug#end()

"------------------
" General Settings
"------------------

set termguicolors
colorscheme nord
" Change a few of the nord color scheme settings
hi IncSearch cterm=none ctermfg=15 ctermbg=12 gui=none guifg=#ECEFF4 guibg=#5E81AC

set autoindent
set smartindent
set list 					" show trailing whitespace
set number
set noshowmode				" don't show '-- INSERT --' line
set completeopt-=preview 	" don't show preview for docs
set cursorline				" highlight cursor line
set mouse=a					" use mouse everywhere ('a' for 'all')
set nowrap					" no line wrapping!


set inccommand=nosplit		" show live preview of replacements

let g:deoplete#enable_at_startup = 1
call deoplete#custom#source('_', 'max_menu_width', 80)

let g:echodoc#enable_at_startup = 1
let g:echodoc#type = "floating"

let g:airline#extensions#ale#enabled = 1

let g:ale_virtualtext_cursor = 1
let g:ale_sign_error = ' ✖'
let g:ale_sign_warning = ' ⚠'

let g:NERDTreeShowHidden = 1	" show hidden files
let g:NERDTreeChDirMode = 2 	" allow nerdtree to set cwd


nmap ; :Files<CR>
nmap <C-n> :NERDTreeToggle<CR>

set title
set titlestring=%t

set tabstop=4

let g:ale_linters = {
	\ 'go': ['gopls'],
	\}

au FileType go set shiftwidth=4
