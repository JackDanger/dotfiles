if exists("ftplugin_did_load_javascript")
  finish
endif
let ftplugin_did_load_javascript = 1

nmap <leader>B <ESC>yiWo<ESC>ccconsole.log("<ESC>"0pa", <ESC>"0pa)<ESC>kJi<CR><ESC>:w<CR>
nmap <leader>b <ESC>yiwo<ESC>ccconsole.log("<ESC>"0pa", <ESC>"0pa)<ESC>kJi<CR><ESC>:w<CR>

" Add a pdb.trace() right below current line
"nmap <leader>b <ESC>o<ESC>ccimport pdb; pdb.set_trace()<ESC>:w<CR>

map <leader>7 :set textwidth=72<CR>
map <leader>1 :set textwidth=120<CR>
