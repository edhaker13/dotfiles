set term=xterm
set t_Co=256
" Use <leader>l to toggle display of whitespace
nmap <leader>l :set list!<CR>
set listchars=tab:»\ ,eol:¬     " And set some nice chars to do it with

set autochdir                   " automatically change to file's dir
set autoindent                  " preserve current indent on new lines
set textwidth=0                 " disable wrap
set backspace=indent,eol,start  " make backspaces delete sensibly
set enc=utf-8
set fenc=utf-8
set termencoding=utf-8

set tabstop=2                   " indentation levels every two columns
set expandtab                   " convert all tabs typed to spaces
set shiftwidth=2                " indent/outdent by two columns
set shiftround                  " indent/outdent to nearest tabstop
set nowrap

set matchpairs+=<:>             " allow % to bounce between angles too

set vb                          " use visual bell instead of beeping

set incsearch                   " incremental search

set ignorecase                  " ignore case when searching
set smartcase                   " ignore case if search patter is all

set hlsearch                    " highlight search

set title                       " change the terminal's title
set ruler                       " ruler

set fillchars=vert:\|           " change splitter

set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc

syntax on                       " syntax highlighting
colorscheme molokai             " colour scheme
set nospell                     " don't check for spelling errors
" dont use Q for Ex mode
map Q :q
" make tab in v mode ident code
vmap <tab> >gv
vmap <s-tab> <gv

" make tab in normal mode ident code
nmap <tab> I<tab><esc>
nmap <s-tab> ^i<bs><esc>

" taglist
filetype on
nnoremap <silent> <F8> :TlistToggle<CR>

filetype plugin indent on

" This unsets the "last search pattern" register by hitting return
nnoremap <CR> :noh<CR><CR>

" Toggle line numbers and fold column for easy copying:
nnoremap <F2> :set nonumber!<CR>:set foldcolumn=0<CR>

" following some perl specific settings

" autoindent
autocmd FileType perl set autoindent|set smartindent

" 4 space tabs
au FileType perl set tabstop=4|set shiftwidth=4|set expandtab|set softtabstop=4

" 4 space tabs
au FileType python set tabstop=4|set shiftwidth=4|set expandtab|set softtabstop=4

" show matching brackets
au FileType perl set showmatch

" check perl code with :make
au FileType perl set makeprg=perl\ -wc\ %\ $*
au FileType perl set errorformat=%f:%l:%m
au FileType perl set autowrite

" Trim trailing whitespace
au FileType c,cpp,java,php,perl,python,html,htmldjango,mason,tt2html,css au BufWritePre * :%s/\s\+$//e

" Restore position in a file
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif

set bg=dark                     " set dark background
" Sets colorcolumn to 80 if exists
if exists('+colorcolumn')
    set colorcolumn=80
else
    au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%80v.\+', -1)
endif
