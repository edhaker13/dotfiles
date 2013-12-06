" SPF-13 settings
let g:spf13_bundle_groups=['general', 'neocomplcache', 'programming', 'php', 'python', 'html', 'misc']
let g:spf13_use_powerline=1

" Powerline
" Remove airline if installed"
UnBundle 'bling/vim-airline'

if has('statusline')
  let g:Powerline_symbols='fancy'
  set laststatus=2 " Always display the statusline in all windows
  set noshowmode " Hide mode text (e.g. -- INSERT -- below the statusline)
endif

" Use <leader>l to toggle display of whitespace
nmap <leader>l :set list!<CR>
set autochdir                   " automatically change to file's dir
if ! has('win32') || has('win64')
  " Set default file encodings
  set encoding=utf-8
  set fileencoding=utf-8
  set termencoding=utf-8
endif

set vb                          " use visual bell instead of beeping
set title                       " change the terminal's title
set nospell                     " don't check spelling, it's annoying

" taglist
nnoremap <silent> <F8> :TlistToggle<CR>

" Toggle line numbers and fold column for easy copying:
nnoremap <F2> :set nonumber!<CR>:set foldcolumn=0<CR>

set autoindent                  " Indent at the same level of the previous line
set shiftwidth=2                " Use indents of 2 spaces
set expandtab                   " Tabs are spaces, not tabs
set tabstop=2                   " An indentation every four columns
set softtabstop=2               " Let backspace delete indent
set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)

" Sets colorcolumn to 80 if exists

if exists('+colorcolumn')
  set colorcolumn=80
  highlight ColorColumn ctermbg=lightgrey guibg=lightgrey
else
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%80v.\+', -1)
endif
if has('gui_running')
  colorscheme molokai
  set bg=dark
else
  colorscheme molokai
  set bg=dark
endif
