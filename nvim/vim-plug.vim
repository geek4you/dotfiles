" Fold vimrc
set fdm=marker

" Plugin Settings {{{
if &compatible
  set nocompatible               " Be iMproved
endif

let vimplugInstalled=0
let plugvim=expand('~/.config/nvim/autoload/plug.vim')

if !filereadable(plugvim)
    echo "Installing vim-plug.."
    echo ""
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    let vimplugInstalled=1
endif

call plug#begin('~/.config/nvim/plugged')

"--------------------------------------------------------------------------}}}
" Plugins {{{

let g:is_exuberant = 0

" Language plugins
let g:web_dev_plugins = 1

" Overrides
if filereadable(expand('~/.vimrc.local'))
    source ~/.vimrc.local
endif

" My bundles here:
" original repos on GitHub
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'
Plug 'majutsushi/tagbar'
Plug 'scrooloose/syntastic'
Plug 'mbbill/undotree'
Plug 'altercation/vim-colors-solarized'
Plug 'sickill/vim-monokai'
Plug 'morhetz/gruvbox'
Plug 'w0ng/vim-hybrid'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'terryma/vim-multiple-cursors'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'tpope/vim-surround' "manipulate parenthesis
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'Shougo/unite.vim'
Plug 'Shougo/neomru.vim'
Plug 'Shougo/neoyank.vim'
Plug 'xolox/vim-misc'
Plug 'tomtom/tcomment_vim'
Plug 'Lokaltog/vim-easymotion'
Plug 'airblade/vim-gitgutter'
Plug 'mhinz/vim-grepper'
Plug 'embear/vim-localvimrc'
Plug 'iamcco/markdown-preview.vim'
"Plug 'kassio/neoterm' " neovim
"Plug 'bfredl/nvim-ipy' " neovim

function! DoRemote(arg)
  UpdateRemotePlugins
endfunction

Plug 'Shougo/deoplete.nvim', { 'do' : function('DoRemote') }
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'davidhalter/jedi-vim'
Plug 'xolox/vim-lua-ftplugin'
Plug 'guns/vim-clojure-static'
Plug 'chase/vim-ansible-yaml'
Plug 'Shougo/echodoc'
Plug 'ensime/ensime-vim', { 'do' : function('DoRemote') }
Plug 'derekwyatt/vim-scala'

" Web dev
" npm install tern in bundles/tern
" npm install -g jshint
if g:web_dev_plugins == 1
    Plug 'mattn/emmet-vim'
    Plug 'tmhedberg/matchit'
    Plug 'Valloric/MatchTagAlways'
    Plug 'pangloss/vim-javascript'
    Plug 'othree/javascript-libraries-syntax.vim'
    Plug 'ternjs/tern_for_vim', { 'do' : 'npm install' }
    Plug 'carlitux/deoplete-ternjs'
    Plug 'moll/vim-node'
    Plug 'briancollins/vim-jst'
endif

if g:is_exuberant
    Plug 'xolox/vim-easytags'
endif

call plug#end()

filetype plugin indent on     " required!

if vimplugInstalled == 1
    echo "Installing Plugins, please ignore key map error messages"
    echo ""
    PlugInstall
    UpdateRemotePlugins
endif

"---------------------------------------------------------------------------}}}
" Colorscheme and Fonts {{{
set background=dark
"let $NVIM_TUI_ENABLE_TRUE_COLOR=1
colorscheme solarized
" set t_Co=256

"---------------------------------------------------------------------------}}}
" Features {{{
"
syntax on "Enable syntax highlighting

" Copy ubuntu clipboard
if has('unnamedplus')
    set clipboard=unnamedplus
else
    set clipboard=unnamed
endif

set colorcolumn=80 "Highlight column 80, page border

"set tw=79 " Wrap text at column 79
set nowrap

" Auto remove trailing whitespace
autocmd BufWritePre * :%s/\s\+$//e

" Autocd to current file directory safely
" autocmd BufEnter * silent! lcd %:p:h

"---------------------------------------------------------------------------}}}
" Must have options {{{
"
set hidden
" Better command-line completion
set wildmenu
" Show partial commands in the last line of the screen
set showcmd
" Highlight searches
set hlsearch
" Incremental seatch
set incsearch
" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase
" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start
" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on. Useful for READMEs, etc.
set autoindent
" Stop certain movements from always going to the first character of a line.
set nostartofline
" Display the cursor position on the last line of the screen or in the status
set ruler
" Always display the status line, even if only one window is displayed
set laststatus=2
" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm
" Use visual bell instead of beeping when doing something wrong
set visualbell
" And reset the terminal code for the visual bell. If visualbell is set, and
set t_vb=
" Enable use of the mouse for all modes
set mouse=a
" Set the command window height to 2 lines, to avoid many cases of having to
set cmdheight=2
" Display line numbers on the left
set number
"set relativenumber "causes slowness
" Quickly time out on keycodes, but never time out on mappings
set notimeout ttimeout ttimeoutlen=50
" Use <F11> to toggle between 'paste' and 'nopaste'
set pastetoggle=<F11>
" Natural slpit opening
set splitbelow
set splitright
"---------------------------------------------------------------------------}}}
" Indentation options {{{
"
" Indentation settings for using 2 spaces instead of tabs.
" Do not change 'tabstop' from its default value of 8 with this setup.
set shiftwidth=4
set softtabstop=4
set expandtab
" Do not push preprocessor directives left
set cinkeys-=0#
" Indentation settings for using hard tabs for indent. Display tabs as
" two characters wide.
"set shiftwidth=2
"set tabstop=2
autocmd Filetype javascript setlocal ts=2 sw=2 expandtab
autocmd Filetype lua setlocal ts=2 sw=2 expandtab

"---------------------------------------------------------------------------}}}
" Mappings {{{
"
" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
map Y y$
" Map <F3> (redraw screen) to also turn off search highlighting until the
nnoremap <F8> :nohl<CR>
" NERD toggle
nnoremap <F2> :NERDTreeToggle<CR>
" Gundo toggle
nnoremap <F3> :UndotreeToggle<CR>
" Tagbar toggle
nnoremap <F4> :TagbarToggle<CR>
" Switch buffers using alt+number
nnoremap <A-1> :1b<CR>
nnoremap <A-2> :2b<CR>
nnoremap <A-3> :3b<CR>
nnoremap <A-4> :4b<CR>
nnoremap <A-5> :5b<CR>
nnoremap <A-6> :6b<CR>
nnoremap <A-7> :7b<CR>
nnoremap <A-8> :8b<CR>
nnoremap <A-9> :9b<CR>
nnoremap <A-0> :10b<CR>
" Switch windows using ctrl+hjkl
inoremap <C-W> <C-O><C-W>
noremap <C-J> <C-W>j
noremap <C-K> <C-W>k
noremap <C-H> <C-W>h
noremap <C-L> <C-W>l
" Fast resize
if bufwinnr(1)
  map + <C-W>+
  map - <C-W>-
endif

" Nvim terminal mapping
tnoremap <esc> <C-\><C-n>
command! Term :sp | term

"---------------------------------------------------------------------------}}}
" External Plugin Settings {{{
if g:is_exuberant
    source ~/dotfiles/vim/plugin-settings/easytags.vim
endif
source ~/dotfiles/vim/plugin-settings/fzf.vim
source ~/dotfiles/vim/plugin-settings/ultisnips.vim
source ~/dotfiles/vim/plugin-settings/unite.vim
source ~/dotfiles/vim/plugin-settings/airline.vim
source ~/dotfiles/vim/plugin-settings/syntastic.vim
source ~/dotfiles/vim/plugin-settings/indent-guides.vim
source ~/dotfiles/vim/plugin-settings/echodoc.vim
source ~/dotfiles/vim/plugin-settings/vim-localvimrc.vim
source ~/dotfiles/vim/plugin-settings/markdown-preview.vim
source ~/dotfiles/nvim/plugin-settings/deoplete.vim
source ~/dotfiles/nvim/plugin-settings/jedi-vim.vim
source ~/dotfiles/nvim/plugin-settings/lua-ftplugin.vim
source ~/dotfiles/nvim/plugin-settings/deoplete-ternjs.vim
source ~/dotfiles/nvim/plugin-settings/ensime-vim.vim
source ~/dotfiles/nvim/plugin-settings/nvim-ipy.vim
"---------------------------------------------------------------------------}}}
"Local Machine Settings
if filereadable(expand('~/.vimrc.local'))
    source ~/.vimrc.local
endif
