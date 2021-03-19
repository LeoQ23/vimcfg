" An example for a vimrc file.
"
" Maintainer:    Bram Moolenaar <Bram@vim.org>
" Last change:    2011 Apr 15
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"          for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"        for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.

set nocompatible              " be iMproved, required
filetype off                  " required

filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup        " do not keep a backup file, use versions instead
else
  set backup        " keep a backup file
endif
set history=100        " keep 50 lines of command line history
set ruler        " show the cursor position all the time
set showcmd        " display incomplete commands
set incsearch        " do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else
  set autoindent        " always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
          \ | wincmd p | diffthis
endif

" plugins manager - vim-plug
call plug#begin()
Plug 'preservim/NERDTree'
Plug 'https://github.com/itchyny/lightline.vim'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'preservim/tagbar'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'ludovicchabant/vim-gutentags'
Plug 'jceb/vim-orgmode'
Plug 'tpope/vim-speeddating'
Plug 'vim-scripts/utl.vim'
Plug 'tpope/vim-repeat'
Plug 'yegappan/taglist'
Plug 'preservim/tagbar'
Plug 'chrisbra/NrrwRgn'
Plug 'mattn/calendar-vim'
Plug 'inkarkat/vim-SyntaxRange'
Plug 'tpope/vim-fugitive'
call plug#end()

" Customize setting
set nu rnu
set tabstop=4
set expandtab
set softtabstop=4
set shiftwidth=4
set whichwrap+=<,>,h,l
set splitright

" Set to auto read when a file is changed from the outside
set autoread

" Set mapleader
let mapleader = " "
let maplocalleader = ","

" Fast editing of .vimrc
map <silent> <leader>fed :e ~/.vimrc<cr>
" When .vimrc is edited, reload it
autocmd! bufwritepost .vimrc source ~/.vimrc

" Fast saving
nmap <leader>w :w!<cr>
" Fast quit
nmap <leader>q :qa<cr>

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Turn backup off,since most stuff is in SVN,git et.c anyway...
set nobackup
set nowb
set noswapfile

" Treat long lines as bread lines(useful when moving around in them)
map j gj
map k gk

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" auto change working dir
autocmd BufEnter * if expand("%:p:h") !~ '^/tmp' | silent! lcd %:p:h | endif

" ctrl c and v to clipboard
vmap <C-c> "+y
nmap <C-a> ggVG
nmap <C-v> "+p

" set nerdtree mapping
" map <F3> :NERDTreeMirror<cr>
let g:NERDTreeShowLineNumbers=1
map <F3> :NERDTreeToggle<cr>
map <F4> :NERDTreeToggle<cr>:NERDTreeCWD<cr>

" set transparent, defaut is transparent
hi Normal ctermfg=255 ctermbg=none
hi LineNr ctermfg=255 ctermbg=none
let g:btransparent=1

nmap bu :<C-U>execute 'buffer ' . v:count<CR>
nmap bn :bn<cr>
nmap bp :bp<cr>

" set fdm=indent
set autowrite
set ignorecase smartcase

" set tagbar mapping key
nmap <F8> :TagbarToggle<CR>

" map tab
nmap tn :tabn<cr>
nmap tp :tabp<cr>

" set airline to use powerline fonts
let g:airline_powerline_fonts = 1
let g:airline_theme='cool'

" set encoding=utf-8 fileencodings=ucs-bom,utf-8,cp936

" set customize highlight color
hi CursorLine ctermbg=240 ctermfg=230

" Locate and return character "above" current cursor position.
function! LookUpwards()
    let column_num = virtcol('.')
    let target_pattern = '\%' . column_num . 'v.'
    let target_line_num = search(target_pattern . '*\S', 'bnW')

    if !target_line_num
        return ""
    else
        return matchstr(getline(target_line_num), target_pattern)
    endif
endfunction

imap <silent> <C-Y> <C-R><C-R>=LookUpwards()<CR>
noremap <CR> :nohlsearch<CR>

set tws=15x0
map <F5> :bel term<CR>

" Do not show the message at launching nothing
set shortmess=atI

tnoremap <F1> <C-W>N

" Add coordination line
" set bg=dark
set cursorline
set cursorcolumn
set colorcolumn=81

" See [http://vim.wikia.com/wiki/Highlight_unwanted_spaces]
" - highlight trailing whitespace in red
" - have this highlighting not appear whilst you are typing in insert mode
" - have the highlighting of whitespace apply when you open new buffers
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches() " for performance

" Config lightline
set laststatus=2

" colorschema
colo solarized8
set background=dark

" grep find
nmap <leader>fg :!grep -rn <C-R><C-R>=expand("<cword>")<CR>
" fzf config
map <leader>f :Files<CR>
map <leader>cd :Files
map <leader>b :Buffers<CR>
map <leader>h :History<CR>
map <leader>g :Commits<CR>
map <leader>bg :BCommits<CR>
map <leader>t :Tags <C-R><C-R>=expand("<cword>")<CR>
map <leader>bt :BTags <C-R><C-R>=expand("<cword>")<CR>
map <leader>nle :Files /mnt/d/Project/NLEPlatformPro_Git<CR>

" ctags settings
set tags=./.tags;$HOME

" gutentags configuration

" gutentags搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归 "
let g:gutentags_project_root = ['.project', '.repo']
" 所生成的数据文件的名称 "
let g:gutentags_ctags_tagfile = '.tags'
" 将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录 "
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags
" 检测 ~/.cache/tags 不存在就新建 "
if !isdirectory(s:vim_tags)
   silent! call mkdir(s:vim_tags, 'p')
endif

" 配置 ctags 的参数 "
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+pxI']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

" WSL yank support
let s:clip = '/mnt/c/Windows/System32/clip.exe'  " change this path according to your mount point
if executable(s:clip)
    augroup WSLYank
        autocmd!
        autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
    augroup END
endif

map <leader>jn :%!python3 -m json.tool<CR>
