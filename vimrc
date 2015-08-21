" Default
let mapleader = '\'

" Rocking hard. No leader timeout
set notimeout

" Alias these common mistypes, Shitf+w -> w
"command W w
command Wq wq
command WQ wq
command Q q
nmap EE :e!<CR>
nmap QQ :q!<CR>

color vividchalk

" From http://stackoverflow.com/questions/676600/vim-search-and-replace-selected-text
" By pressing ctrl + r in the visual mode you will be prompted to enter text to replace with. Press enter and then confirm each change you agree with 'y' or decline with 'n'.
" This command will override your register 'h' so you can choose other one ( by changing 'h' in the command above to other lower case letter ) that you don't use.
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

" Leader-A sets up Ag to search for your selection (or the current word)
nnoremap <leader>A viw"hy:Ag '<C-r>h'
vnoremap <leader>A "hy:Ag '<C-r>h'

" Press F2 to paste without weird autointents
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>

map <leader>l :Align
nmap <leader>a :Ag
nmap <leader>] :TagbarToggle<CR>
nmap <leader><space> :call whitespace#strip_trailing()<CR>
nmap <leader>h :nohl<CR>

" Insert Go's err != nil checks automatically
imap <leader>e <CR>if err != nil {<CR>return nil, err<CR>}<CR>
nmap <leader>e <ESC>oif err != nil {<CR>return nil, err<CR>}<CR><ESC>

" \> goes to the next quickfix entry
nmap <leader>> :cnext<CR>
" \> autosaves and goes to the next quickfix entry in insert mode
imap <leader>> <ESC>:w<CR>:cnext<CR>
" \< goes backward
nmap <leader>< :cprevious<CR>
imap <leader>< <ESC>:w<CR>:cprevious<CR>

set showmode
set autowrite
set nowritebackup
set nobackup
set noswapfile
set showcmd
set autoread        " reload files when changed on disk
set encoding=utf-8

" keep the curser in the middle of the screen
map <leader>o :set scrolloff=99999<CR>
map <leader>O :set scrolloff=0<CR>

set listchars=tab:\ \ ,trail:▫
set wildmenu
set wildmode=longest,list,full

" recognize markdown
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
" Add \( to be a way to turn text into links
autocmd FileType markdown vmap <buffer> <leader>( S)i[]<ESC>ha
autocmd FileType markdown nmap <buffer> <leader>( ysiw)i[]<ESC>ha
" Add \[ to be a way to turn href into links
autocmd FileType markdown vmap <buffer> <leader>[ S]f]a()<ESC>ha
autocmd FileType markdown nmap <buffer> <leader>[ ysiw]f]a()<ESC>ha


" Autoresizing
autocmd VimResized * :wincmd =

" Surround a word with \s
nmap <leader>s ysiw
nmap <leader>S ysiW

" Ruby:
" Turn instance variables into `let`s
nmap <leader>L 0f@slet(:<ESC>f i)<ESC>f=s{<ESC>A }<ESC>
" Turn { |a| b }
" into
" do |a|
"   b
" end
nmap <leader>d 0f{sdo<CR><ESC>f}hxs<CR>end<ESC>
" Turn {
"   { a: :b }
" }
" into
" do
"   { a: :b }
" end
nmap <leader>D 0f{%i<CR><ESC><right>mDkdd%so<CR><ESC>k$id<ESC>`Dsend<ESC>

" Add a binding.pry right above current line
nmap <leader>B <ESC>O<ESC>ccrequire 'pry'<CR>binding.pry<ESC>:w<CR>
" Add a binding.pry right below current line
nmap <leader>b <ESC>o<ESC>ccrequire 'pry'<CR>binding.pry<ESC>:w<CR>

" Insert pry without needing it in the Gemfile
nmap <leader>P <ESC>:r!naked-pry<CR>

" Wrap the current word in an escaped Mustache tag
nmap <leader>M <ESC>ysiW}lysiW}lysiW}ea<Space><ESC>ea<Space><ESC>b

" CTRL+direction to move panes
map <C-h> <C-w>h
map <C-j> <C-w><C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" type 'jj' in insert mode to escape.
inoremap jj <ESC>
" type ';;' in insert mode to escape and save
inoremap ;; <ESC>:w<CR>
" type ';;' in normal mode to save
nnoremap ;; <ESC>:w<CR>

" Connect to system clipboard
set clipboard=unnamed

" Let's use `brew install fzf`
set rtp+=~/.fzf/

map <C-p> :FZF<CR>

" Always start on the first line of a git commit message
autocmd FileType gitcommit call setpos('.', [0, 1, 1, 0])

" camelCasing for free
nnoremap + /\$\w\+_<CR>
nnoremap _ f_x~

" Autosave
:au FocusLost * silent! wa

" Don't do funny stuff with JSON double quotes
let g:vim_json_syntax_conceal = 0

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

" ********************************
"
" Custom Jack Danger vim
"
" ********************************

set ruler

" Use Pathogen
execute pathogen#infect()

" Use local golang plugin
filetype off
filetype plugin indent off
set runtimepath+=$GOROOT/misc/vim
filetype plugin indent on
syntax on

" Disable syntastic for go?
"let g:syntastic_go_checkers=[]
" `go fmt` before save
"autocmd FileType go autocmd BufWritePre <buffer> GoFmt
unmap <leader>f
autocmd FileType go map <leader>f :GoFmt<CR>

set tabstop=2
set shiftwidth=2
set expandtab " Overwritten for go, useful everywhere else

