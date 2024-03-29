" Adiciona uma linha vazia abaixo ou acima retornando ao modo normal e a posicao anterior
nnoremap <silent> <leader>o <esc>:let currentPosition=getpos('.')<CR>o<Esc>:call setpos('.',currentPosition)<CR>
nnoremap <silent> <leader>O <esc>:let currentPosition=getpos('.')<CR>O<Esc>:call setpos('.',[currentPosition[0],currentPosition[1]+1,currentPosition[2],currentPosition[3]])<CR>

" navega entre linhas virtuais e reais naturalmente
nnoremap j gj
nnoremap k gk

" Navegacao entre as janelas 
nnoremap <C-h> <C-W>h
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-l> <C-W>l

" redimensiona janelas usando ctr-{up,down,left,right}
nnoremap <silent> [1;5A :resize +2<CR>
nnoremap <silent> [1;5B :resize -2<CR>
nnoremap <silent> [1;5C :vertical resize -2<CR>
nnoremap <silent> [1;5D :vertical resize +2<CR>

" from https://github.com/ThePrimeagen/.dotfiles
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z

set timeoutlen=400
