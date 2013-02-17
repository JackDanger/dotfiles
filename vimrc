" Alias these common mistypes, Shitf+w -> w
command Wq wq
command WQ wq
command Q q

color vividchalk

vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>
" From http://stackoverflow.com/questions/676600/vim-search-and-replace-selected-text
" By pressing ctrl + r in the visual mode you will be prompted to enter text to replace with. Press enter and then confirm each change you agree with 'y' or decline with 'n'.
" This command will override your register 'h' so you can choose other one ( by changing 'h' in the command above to other lower case letter ) that you don't use.

nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode
