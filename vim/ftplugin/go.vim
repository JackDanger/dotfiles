if exists("ftplugin_did_load_go")
  finish
endif
let ftplugin_did_load_go = 1

" Insert Go's err != nil checks automatically
imap <leader>e <CR>if err != nil {<CR>return nil, err<CR>}<CR>
nmap <leader>e <ESC>oif err != nil {<CR>return nil, err<CR>}<CR><ESC>

" Automatically insert debug lines
imap <leader>P <ESC>"tyiWo<ESC>V:s/^/\=printf("fmt.Printf(\"%s:%d %%#v\\\n\")", expand("%s:t"), line("'<"))<CR>$"tP
nmap <leader>P "tyiWo<ESC>V:s/^/\=printf("fmt.Printf(\"%s:%d %%#v\\n\", )", expand("%s:t"), line("'<"))<CR>$"tP
imap <leader>p <ESC>"tyiwo<ESC>V:s/^/\=printf("fmt.Println(\"%s:%d %%#v\\n\")", expand("%s:t"), line("'<"))<CR>$"tP
nmap <leader>p "tyiwo<ESC>V:s/^/\=printf("fmt.Printf(\"%s:%d %%\#v\\n\", )", expand("%s:t"), line("'<"))<CR>$"tP

nmap gd :GoDef<CR>
nmap gf :GoFmt<CR>

" Use gopls LSP for everything
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'

" Disable syntastic for go?
let g:syntastic_aggregate_errors = 1
let g:syntastic_go_checkers = ['golint', 'govet']
function EnableGoCheckers ()
  let g:syntastic_go_checkers = ['go', 'golint', 'govet']
endfunction
function DisableGoCheckers ()
  let g:syntastic_go_checkers = ['golint', 'govet']
endfunction

" Always `go fmt` on save


" run go vet in the quickfix list
nmap <leader>v :cexpr system("go vet ./") \| copen

" Turn on `go build` checking on save
map <leader>b :call DisableGoCheckers()<CR>
" And turn it back off
map <leader>B :call EnableGoCheckers()<CR>
