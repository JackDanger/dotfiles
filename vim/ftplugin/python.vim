if exists("ftplugin_did_load_python")
  finish
endif
let ftplugin_did_load_python = 1

"gd to go to definitions
nmap gd  :YcmCompleter GoToDefinitionElseDeclaration<CR>

" Add a pdb.trace() right above current line
nmap <leader>B <ESC>O<ESC>ccimport pdb; pdb.set_trace()<ESC>:w<CR>
" Add a pdb.trace() right below current line
nmap <leader>b <ESC>o<ESC>ccimport pdb; pdb.set_trace()<ESC>:w<CR>

set tabstop=4
set softtabstop=4
set shiftwidth=4
set textwidth=120
set expandtab
set autoindent
set fileformat=unix
