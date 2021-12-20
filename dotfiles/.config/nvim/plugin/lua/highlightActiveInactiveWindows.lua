-- Cores para janelas inativas e ativas
vim.cmd('hi InactiveWindow guibg=#333333')
vim.cmd('hi link ActiveWindow Normal')

autocommands = {} -- or wherever you prefer

autocommands.win_enter = function()
    local filetype = vim.bo.filetype

    -- nao aplica em tipos help e manpages
    if filetype ~= 'help' and filetype ~= 'man' then
        vim.cmd('set winhighlight=Normal:ActiveWindow,NormalNC:InactiveWindow')
        vim.cmd [[IndentBlanklineEnable]]
        vim.opt.relativenumber = true
    end
end

autocommands.win_leave = function()
    vim.cmd('set winhighlight=Normal:InactiveWindow,NormalNC:InactiveWindow')
    vim.cmd [[IndentBlanklineDisable]]
    vim.opt.relativenumber = false
end

vim.api.nvim_exec([[
augroup line_return
    au!
    au WinEnter,FocusGained * lua autocommands.win_enter()
    au WinLeave,FocusLost,BufLeave * lua autocommands.win_leave()
augroup END
]], false)
