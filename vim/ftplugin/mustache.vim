if exists("ftplugin_did_load_mustache")
  finish
endif
let ftplugin_did_load_mustache = 1
" Wrap the current word in an escaped Mustache tag
nmap <leader>M <ESC>ysiW}lysiW}lysiW}ea<Space><ESC>ea<Space><ESC>b
