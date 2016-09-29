if exists("ftplugin_did_load_python")
  finish
endif
let ftplugin_did_load_python = 1

"gd to go to definitions
nmap gd  :YcmCompleter GoToDefinitionElseDeclaration<CR>

set tabstop=4
set softtabstop=4
set shiftwidth=4
set textwidth=79
set expandtab
set autoindent
set fileformat=unix
