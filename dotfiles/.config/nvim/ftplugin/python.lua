vim.wo.colorcolumn      = '80'
vim.wo.foldmethod       = 'indent'
vim.wo.foldlevel        = 99

vim.opt.listchars       = { trail = '•', eol = '↲', tab = '▸\'' }
-- vim.api.nvim_command('autocmd BufWinEnter *.py normal! zM')
vim.g.python3_host_prog = '$VIRTUAL_ENV/bin/python3'
-- vim.api.nvim_command('autocmd BufWritePre *.py lua vim.lsp.buf.format()')
-- vim.cmd [[autocmd BufEnter *.py normal zM]]
-- vim.cmd [[let g:python3_host_prog = '$VIRTUAL_ENV/bin/python3']]
-- vim.cmd [[autocmd BufWritePre *.py lua vim.lsp.buf.format()]]
