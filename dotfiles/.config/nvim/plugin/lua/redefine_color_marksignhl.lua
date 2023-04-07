vim.api.nvim_exec([[
augroup redefine_group_marksignhl
    au!
    au ColorScheme * silent! luavim.api.nvim_set_hl(0, "MarkSignHL", {link = "GruvboxBlueSign"})
augroup END
]], false)
