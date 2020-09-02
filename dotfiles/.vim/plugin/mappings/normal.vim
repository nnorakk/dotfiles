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

" equaliza tamanho das janelas
nnoremap <Leader>= <C-W>=
" converte de vertical para horizontal as janelas
nnoremap <Leader>- <c-w>t<c-w>K
" converte de horizontal para vertical as janelas
nnoremap <Leader>\ <c-w>t<c-w>H
nnoremap <Leader>\| <c-w>t<c-w>H

nnoremap <Leader>q :quit<CR>
nnoremap <Leader>w :write<CR>
nnoremap <Leader>x :xit<CR>
nnoremap <Leader>so :source %<CR>
