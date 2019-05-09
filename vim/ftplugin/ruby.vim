if exists("ftplugin_did_load_ruby")
  finish
endif
let ftplugin_did_load_ruby = 1
" Turn instance variables into `let`s
nmap <leader>L 0f@slet(:<ESC>f i)<ESC>f=s{<ESC>A }<ESC>

" Turn
"   { |a| b }
" into
"   do |a|
"     b
"   end
nmap <leader>D 0f{sdo<CR><ESC>f}hxs<CR>end<ESC>

" Turn
"   do |a|
"     b
"   end
" into
"   { a: :b }
nmap <leader>d 0?<SPACE>do<CR>mD%ce}<ESC>kJ`Dce {<ESC>J

" Add a binding.pry right above current line
nmap <leader>B <ESC>O<ESC>ccrequire 'pry'<CR>binding.pry<ESC>:w<CR>mP
" Add a binding.pry right below current line
nmap <leader>b <ESC>o<ESC>ccrequire 'pry'<CR>binding.pry<ESC>:w<CR>mP

" Insert pry without needing it in the Gemfile
nmap <leader>P <ESC>:r!naked-pry<CR>

