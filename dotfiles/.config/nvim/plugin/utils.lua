-- from https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua
-- Highlight on yank
vim.api.nvim_exec([[
augroup YankHighlight
    au!
    au TextYankPost * silent! lua vim.highlight.on_yank() 
augroup END
]], false)
