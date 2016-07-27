if exists("ftplugin_did_load_markdown")
  finish
endif
let ftplugin_did_load_markdown = 1
" Add \( to be a way to turn text into links
autocmd FileType markdown vmap <buffer> <leader>( S)i[]<ESC>ha
autocmd FileType markdown nmap <buffer> <leader>( ysiw)i[]<ESC>ha
" Add \[ to be a way to turn href into links
autocmd FileType markdown vmap <buffer> <leader>[ S]f]a()<ESC>ha
autocmd FileType markdown nmap <buffer> <leader>[ ysiw]f]a()<ESC>ha

