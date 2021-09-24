set nocompatible

" Load all active extensions
set rtp+=~/.dotfiles/vim-extensions/use/*

" Some local filetype-specific config
set rtp+=~/.dotfiles/vim

" Make backspace behave in a sane manner.
set backspace=indent,eol,start

" Use syntax highlighting on
syntax on

" Enable file type detection and do language-dependent indenting.
filetype plugin indent on

" Show line numbers on the left
set number

" And lines/columns in the status bar
set ruler

" It's not 1997 anymore
set nojoinspaces

" Allow hidden buffers, don't limit to 1 file per window/split
set hidden
" Default
let mapleader = '\'

" Don't change the cwd when opening a buffer
set noautochdir

" Rocking hard. 800 milliseconds to execute a leader combo
set timeoutlen=800
set ttimeoutlen=0

" Alias these common mistypes, Shitf+w -> w
command W w
command Wq wq
command WQ wq
command Q q
nmap EE :e!<CR>
nmap QQ :q!<CR>

" There's no good color scheme
color default

" From http://stackoverflow.com/questions/676600/vim-search-and-replace-selected-text
" By pressing ctrl + r in the visual mode you will be prompted to enter text to replace with. Press enter and then confirm each change you agree with 'y' or decline with 'n'.
" This command will override your register 'h' so you can choose other one ( by changing 'h' in the command above to other lower case letter ) that you don't use.
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

" Leader-A sets up Ag to search for your selection (or the current word)
nnoremap <leader>A viw"hy:Ag '<C-r>h'
vnoremap <leader>A "hy:Ag '<C-r>h'
" And lowercase just gives you the search prompt
nmap <leader>a :Ag

" Press F2 to paste without weird autointents
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>

map <leader>l :Align
nmap <leader>] :TagbarToggle<CR>
nmap <leader>h :nohl<CR>

" Autoresizing
autocmd VimResized * :wincmd =

" Surround a word with \s (uses surround.vim)
nmap <leader>s ysiw
nmap <leader>S ysiW

" Go to the next place that ctags thinks a thing might be defined
noremap <C-d> :tn<CR>

" Define markdown filetype
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
" Define HAR files as json
autocmd BufNewFile,BufReadPost *.har set filetype=json


" Go to the last line that we were on in a file:
function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction

augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END

" ********************************
"
" Custom Jack Danger vim
"
" ********************************
" Autosave
":au FocusLost * silent! wa

set autoread        " reload files when changed on disk
set autowrite
set expandtab " Overwritten for go, useful everywhere else
set nobackup
set noswapfile
set nowritebackup
set shiftwidth=2
set showcmd
set showmode
set tabstop=2
set listchars=tab:\ \ ,trail:▫
set wildmenu
set wildmode=longest,list,full

" keep the curser in the middle of the screen
map <leader>o :set scrolloff=99999<CR>
map <leader>O :set scrolloff=0<CR>

" type 'jj' in insert mode to escape.
inoremap jj <ESC>
" type ';;' in insert mode to escape and save
" TMP: Unsure if this is worth the cost of losing all semicolons
"inoremap ;; <ESC>:w<CR>
" type ';;' in normal mode to save
nnoremap ;; :w<CR>
nnoremap <C-e> :w<CR>
inoremap <C-e> <ESC>:w<CR>

" Connect to system clipboard
set clipboard=unnamed

" Let's use FZF for our file finding
map <C-p> :FZF<CR>

" I like this shortcut for NERD_tree
map <leader>n :NERDTreeToggle<CR>

" Native Vim/Tmux pane navigation
" https://github.com/christoomey/vim-tmux-navigator
let g:tmux_navigator_no_mappings = 1
let g:tmux_navigator_save_on_switch = 1
nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-j> :TmuxNavigateDown<cr>
nnoremap <silent> <C-k> :TmuxNavigateUp<cr>
nnoremap <silent> <C-l> :TmuxNavigateRight<cr>
inoremap <silent> <C-h> <ESC>:TmuxNavigateLeft<cr>i
inoremap <silent> <C-j> <ESC>:TmuxNavigateDown<cr>i
inoremap <silent> <C-k> <ESC>:TmuxNavigateUp<cr>i
inoremap <silent> <C-l> <ESC>:TmuxNavigateRight<cr>i
"noremap <silent> <C-\> :TmuxNavigatePrevious<cr>

" Break line on commas
nmap <leader>, f,a<CR><ESC>

" @n goes to the next quickfix entry
nmap @n :cnext<CR>
" @n autosaves and goes to the next quickfix entry in insert mode
imap @n <ESC>:w<CR>:cnext<CR>
" @p goes backward
nmap @p :cprevious<CR>
imap @p <ESC>:w<CR>:cprevious<CR>

" Git shortcuts
nmap <leader>gb :Git blame<CR>

" I hacked apart youcompleteme.vim to disable the VimEnter autocmd for the
" following so it could be something I can opt into manually:
let g:skip_youcompleteme_autoload = 1
noremap <leader>Y :call youcompleteme#Enable()<CR>

" If we try to open a directory open NERD_tree
  let NERDTreeIgnore=['\.pyc$', '\.pyo$', '\.rbc$', '\.rbo$', '\.class$', '\.o$', '\~$']

  augroup AuNERDTreeCmd
  autocmd AuNERDTreeCmd VimEnter * call s:CdIfDirectory(expand("<amatch>"))

  " If the parameter is a directory, cd into it
  function s:CdIfDirectory(directory)
    let explicitDirectory = isdirectory(a:directory)
    let directory = explicitDirectory || empty(a:directory)

    if explicitDirectory
      exe "cd " . fnameescape(a:directory)
    endif

    " Allows reading from stdin
    " ex: git diff | mvim -R -
    if strlen(a:directory) == 0
      return
    endif

    if directory
      NERDTree
      wincmd p
      bd
    endif

    if explicitDirectory
      wincmd p
    endif
  endfunction

" Use an interesting status line
set statusline=   " clear the statusline for when vimrc is reloaded
set statusline+=%-3.3n\                      " buffer number
set statusline+=%f\                          " file name
set statusline+=%h%m%r%w                     " flags
set statusline+=[%{strlen(&ft)?&ft:'none'},  " filetype
set statusline+=%{strlen(&fenc)?&fenc:&enc}] " encoding
set statusline+=%=                           " right align
set statusline+=%{synIDattr(synID(line('.'),col('.'),1),'name')}\  " highlight
set statusline+=%b,0x%-8B\                   " current char
set statusline+=%-14.(%l,%c%V%)\ %<%P        " offset

" Use any per-project .vimrc files
set exrc

" And always show it
set laststatus=2
