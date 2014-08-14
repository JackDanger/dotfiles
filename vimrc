
" Default
let mapleader = '\'

" Alias these common mistypes, Shitf+w -> w
command Wq wq
command WQ wq
command Q q
nmap EE :e!<CR>
nmap QQ :q!<CR>

"color vividchalk

vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>
" From http://stackoverflow.com/questions/676600/vim-search-and-replace-selected-text
" By pressing ctrl + r in the visual mode you will be prompted to enter text to replace with. Press enter and then confirm each change you agree with 'y' or decline with 'n'.
" This command will override your register 'h' so you can choose other one ( by changing 'h' in the command above to other lower case letter ) that you don't use.

" Press F2 to paste without weird autointents
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>

map <leader>l :Align
nmap <leader>a :Ack 
nmap <leader>] :TagbarToggle<CR>
nmap <leader><space> :call whitespace#strip_trailing()<CR>
nmap <leader>h :nohl<CR>

set showmode
set autowrite
set nowritebackup
set nobackup
set noswapfile
set showcmd
set autoread        " reload files when changed on disk
set encoding=utf-8

set listchars=tab:\ \ ,trail:▫
set wildmenu
set wildmode=longest,list,full

autocmd VimResized * :wincmd =

" Surround a word with \s
nmap <leader>s ysiw
nmap <leader>S ysiW


" CTRL+direction to move panes
map <C-h> <C-w>h
map <C-j> <C-w><C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" type 'jj' in insert mode to escape.
inoremap jj <ESC>

" Connect to system clipboard
set clipboard=unnamed

" Let's use `brew install fzf`
set rtp+=~/.fzf

map <C-p> :FZF<CR>

" Autosave
:au FocusLost * silent! wa

" Go tags
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

