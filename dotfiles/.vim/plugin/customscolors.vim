" Set comment characters to italic
highlight Comment cterm=italic

" Coluna da numeracao
hi LineNr term=underline ctermfg=3 guifg=grey55 guibg=grey20

" Numero da linha selecionada em destaque
hi CursorLineNr cterm=bold ctermfg=11 gui=bold guifg=Yellow guibg=grey20
"
" Destaque da linha atual
hi CursorLine term=bold cterm=bold guibg=grey20

" Area principal da janela onde ha texto
hi Normal guifg=White guibg=grey10

" Separador vertical de janelas (vsplit)
hi! link VertSplit LineNr

" Areas ainda nao escritas nao ficaram com cores diferentes nem o '~' aparece
hi EndOfBuffer ctermfg=0 ctermbg=0 guifg=bg guibg=bg

" baseada nessa cor o plugin vim-diminactive trabalha
hi ColorColumn guibg=grey20
