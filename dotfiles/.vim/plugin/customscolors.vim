" Set comment characters to italic
highlight Comment cterm=italic

" Coluna da numeracao
highlight LineNr term=underline ctermfg=3 guifg=grey55 guibg=grey20

" Numero da linha selecionada em destaque
highlight CursorLineNr cterm=bold ctermfg=11 gui=bold guifg=Yellow guibg=grey20
"
" Destaque da linha atual
highlight CursorLine term=bold cterm=bold guibg=grey20

" Area principal da janela onde ha texto
highlight Normal guifg=White guibg=grey10

" Separador vertical de janelas (vsplit)
highlight! link VertSplit LineNr

" Areas ainda nao escritas nao ficaram com cores diferentes nem o '~' aparece
highlight EndOfBuffer ctermfg=0 ctermbg=0 guifg=bg guibg=bg

" baseada nessa cor o plugin vim-diminactive trabalha
highlight ColorColumn guibg=grey20

" SignColumn mesmas cores que ColorColumn
highlight! link SignColumn ColorColumn

" Cores pluging Signify
highlight SignifySignAdd cterm=bold gui=bold guifg=#b8bb26 guibg=grey20
highlight SignifySignChange cterm=bold gui=bold guifg=#8ec07c guibg=grey20
highlight SignifySignChangeDelete cterm=bold gui=bold guifg=#8ec07c guibg=grey20
highlight SignifySignDelete cterm=bold gui=bold guifg=#fb4934 guibg=grey20
highlight SignifySignDeleteFirstLine cterm=bold gui=bold guifg=#fb4934 guibg=grey20
