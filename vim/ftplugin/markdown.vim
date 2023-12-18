if exists("ftplugin_did_load_markdown")
  finish
endif
let ftplugin_did_load_markdown = 1
" Add \( to be a way to turn text into links
vmap <buffer> <leader>( S)i[]<ESC>ha
nmap <buffer> <leader>( ysiw)i[]<ESC>ha
" Add \[ to be a way to turn href into links
vmap <buffer> <leader>[ S]f]a()<ESC>ha
nmap <buffer> <leader>[ ysiw]f]a()<ESC>ha
nmap <leader>m :w !grip --export - > /tmp/markdown.html && open /tmp/markdown.html<CR>

nmap <buffer> <leader>I :%s/\(\[.*\]: .*\.png\) width.*$/\1/g<CR>

