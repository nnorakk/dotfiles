-- from https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua
-- Highlight on yank
vim.api.nvim_exec([[
augroup YankHighlight
    au!
    au TextYankPost * silent! lua vim.highlight.on_yank() 
augroup END
]], false)

-- Redefine MarkSignHL para GruvboxBlueSign
vim.api.nvim_exec([[
augroup redefine_group_marksignhl
    au!
    au ColorScheme * silent! lua vim.api.nvim_set_hl(0, "MarkSignHL", {link = "GruvboxBlueSign"})
augroup END
]], false)

vim.cmd('hi InactiveWindow guibg=#333333')
vim.cmd('hi link ActiveWindow Normal')

autocommands = {} -- or wherever you prefer

autocommands.win_enter = function()
    local filetype = vim.bo.filetype

    -- nao aplica em tipos help e manpages
    if filetype ~= 'help' and filetype ~= 'man' then
        vim.cmd('set winhighlight=Normal:ActiveWindow,NormalNC:InactiveWindow')
        require("ibl").setup_buffer(0, { enabled = true })
        vim.opt.relativenumber = true
    end
end

autocommands.win_leave = function()
    vim.cmd('set winhighlight=Normal:InactiveWindow,NormalNC:InactiveWindow')
    require("ibl").setup_buffer(0, { enabled = false })
    vim.opt.relativenumber = false
end

vim.api.nvim_exec([[
augroup line_return
    au!
    au WinEnter,FocusGained,BufReadPre * lua autocommands.win_enter()
    au WinLeave,FocusLost,BufLeave * lua autocommands.win_leave()
augroup END
]], false)
