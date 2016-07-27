if exists("ftplugin_did_load_go")
  finish
endif
let ftplugin_did_load_go = 1

" Insert Go's err != nil checks automatically
imap <leader>e <CR>if err != nil {<CR>return nil, err<CR>}<CR>
nmap <leader>e <ESC>oif err != nil {<CR>return nil, err<CR>}<CR><ESC>

" Automatically insert debug lines
imap <leader>P <ESC>"tyiWo<ESC>V:s/^/\=printf("fmt.Println(\"%s:%d \", )", expand("%s:t"), line("'<"))<CR>$"tP
nmap <leader>P "tyiWo<ESC>V:s/^/\=printf("fmt.Println(\"%s:%d \", )", expand("%s:t"), line("'<"))<CR>$"tP
imap <leader>p <ESC>"tyiwo<ESC>V:s/^/\=printf("fmt.Println(\"%s:%d \", )", expand("%s:t"), line("'<"))<CR>$"tP
nmap <leader>p "tyiwo<ESC>V:s/^/\=printf("fmt.Println(\"%s:%d \", )", expand("%s:t"), line("'<"))<CR>$"tP

" Go tags
" TODO: is this even a thing?
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }

" Disable syntastic for go?
" let g:syntastic_go_checkers = []
" let g:syntastic_go_checkers = ['go', 'golint', 'govet']
let g:syntastic_go_checkers = ['golint', 'govet']
function EnableGoCheckers ()
  let g:syntastic_go_checkers = ['go', 'golint', 'govet']
endfunction
function DisableGoCheckers ()
  let g:syntastic_go_checkers = ['golint', 'govet']
endfunction

" run go vet in the quickfix list
nmap <leader>v :cexpr system("go vet ./") \| copen

" Turn on `go build` checking on save
map <leader>b :call DisableGoCheckers()<CR>
" And turn it back off
map <leader>B :call EnableGoCheckers()<CR>
