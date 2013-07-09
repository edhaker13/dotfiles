" Terminal Settings
set term=xterm
set t_Co=256

" Powerline Fancy
let g:Powerline_symbols = "fancy"
set laststatus=2 " Always display the statusline in all windows
set noshowmode " Hide mode text (e.g. -- INSERT -- below the statusline)

" Use <leader>l to toggle display of whitespace
nmap <leader>l :set list!<CR>
set listchars=tab:»\ ,eol:¬     " And set some nice chars to do it with

set autochdir                   " automatically change to file's dir
set autoindent                  " preserve current indent on new lines
set backspace=indent,eol,start  " make backspaces delete sensibly
set enc=utf-8
set fenc=utf-8
set termencoding=utf-8

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
set nospell                     " don't check for spelling errors
" make tab in v mode indent code
vmap <tab> >gv
vmap <s-tab> <gv

" make tab in normal mode indent code
nmap <tab> I<tab><esc>
nmap <s-tab> ^i<bs><esc>

" taglist
nnoremap <silent> <F8> :TlistToggle<CR>

" Toggle line numbers and fold column for easy copying:
nnoremap <F2> :set nonumber!<CR>:set foldcolumn=0<CR>

" following some perl specific settings

" autoindent
au FileType perl set autoindent|set smartindent

" 4 space tabs
au FileType perl set ts=4 sw=4 et sts=4

" 4 space tabs
au FileType python set ts=4 sw=4 et sts=4

" show matching brackets
au FileType perl set showmatch

" check perl code with :make
au FileType perl set makeprg=perl\ -wc\ %\ $* errorformat=%f:%l:%m autowrite

" Trim trailing whitespace
au FileType c,cpp,java,php,perl,python,html,htmldjango,mason,tt2html,css au BufWritePre * :%s/\s\+$//e

" Restore position in a file
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif

" set tabstop=2                   " indentation levels every two columns
" set softtabstop=2               " indentation edit
" set expandtab                   " convert all tabs typed to spaces
" set shiftwidth=2                " indent/outdent by two columns
" set shiftround                  " indent/outdent to nearest tabstop
" set nowrap                      " dont wrap lines

set ts=2 sts=2 tw=2 sw=2 et shiftround nowrap " set all together
" Sets colorcolumn to 80 if exists
if exists('+colorcolumn')
  set colorcolumn=80
  highlight ColorColumn ctermbg=lightgrey guibg=lightgrey
else
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%80v.\+', -1)
endif
" Use CSApprox converted colours if no gui
if has("gui_running")
  colorscheme ir_black
  set bg=dark
else
  colorscheme ir_black-256
  set bg=dark
endif
