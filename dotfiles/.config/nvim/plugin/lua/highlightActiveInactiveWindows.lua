-- Cores para janelas inativas e ativas
vim.cmd('hi InactiveWindow guibg=#333333')
vim.cmd('hi link ActiveWindow Normal')

_G._autocommands = {} -- or wherever you prefer

_G._autocommands.win_enter = function()
    vim.cmd('set winhighlight=Normal:ActiveWindow,NormalNC:InactiveWindow')
    vim.opt.relativenumber = true
end

_G._autocommands.win_leave = function()
    vim.cmd('set winhighlight=Normal:InactiveWindow,NormalNC:InactiveWindow')
    vim.opt.relativenumber = false
end

vim.api.nvim_exec([[
augroup line_return
    au!
    au WinEnter,FocusGained * lua _autocommands.win_enter()
    au WinLeave,FocusLost,BufLeave * lua _autocommands.win_leave()
augroup END
]], false)
