" cpp.vim: Specific configuration for C++

" Indentation with 2 spaces and moving 2 spaces when reindenting
set shiftwidth=2
set softtabstop=2

" Autoclose quotes, parenthesis, etc
inoremap " ""<left>
inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O
