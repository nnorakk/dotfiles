set laststatus=2
set noshowmode " para de aparecer --INSERT--

" let g:lightline.colorscheme = 'powerline'
" let g:lightline.colorscheme = 'solarized'
let g:lightline = { 'colorscheme': 'molokai', }
let g:lightline = { 'colorscheme': 'seoul256', }
let g:lightline = { 'colorscheme': 'Tomorrow_Night', }
let g:lightline = { 'colorscheme': 'wombat', }
let g:lightline = { 'colorscheme': 'jellybeans', }
let g:lightline = {
      \ 'colorscheme': 'jellybeans',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'filename', 'modified', 'gitbranch'] ],
      \   'right': [['lineinfo'], ['percent'], ['filetype']]
      \ },
      \ 'inactive': {
      \   'left': [ [ 'absolutepath' ] ],
      \ },
      \ 'component_function': {
      \   'gitbranch': 'GitInformation'
      \ },
      \ }

function! GitInformation()
    if !empty(gitbranch#name()) 
        return ' ' . gitbranch#name()
    else
        return ''
    endif
endfunction
