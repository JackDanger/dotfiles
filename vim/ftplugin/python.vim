if exists("ftplugin_did_load_python")
  finish
endif
let ftplugin_did_load_python = 1

"gd to go to definitions
nmap gd  :YcmCompleter GoToDefinitionElseDeclaration<CR>

" Start a IPython session right below current line
" from IPython.terminal.embed import embed; embed()
nmap <leader>B <ESC>o<ESC>ccfrom IPython.terminal.embed import embed; embed()<ESC>kJi<CR><ESC>:w<CR>

" Add a pdb.trace() right below current line
nmap <leader>b <ESC>o<ESC>ccimport pdb; pdb.set_trace()<ESC>:w<CR>

map <leader>7 :set textwidth=72<CR>
map <leader>1 :set textwidth=120<CR>

set tabstop=4
set softtabstop=4
set shiftwidth=4
set textwidth=120
set expandtab
set autoindent
set fileformat=unix
