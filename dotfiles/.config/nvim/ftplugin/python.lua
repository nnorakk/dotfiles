vim.wo.colorcolumn='80'
vim.wo.foldmethod='indent'
vim.wo.foldlevel=99

vim.opt.listchars      = {trail='•',eol='↲', tab='▸\''}
vim.cmd [[normal zM]]
vim.cmd [[let g:python3_host_prog = '$VIRTUAL_ENV/bin/python3']]
vim.cmd [[autocmd BufWritePre *.py lua vim.lsp.buf.formatting_sync(nil, 100)]]
