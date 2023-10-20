-- configura colorscheme gruvbox se existir
local status_ok, _ = pcall(vim.cmd.colorscheme, "gruvbox")
if not status_ok then --
    return
end
vim.cmd('hi InactiveWindow guibg=#333333')
vim.cmd('hi link ActiveWindow Normal')

-- redefine cores baseado no colorscheme gruvbox
vim.api.nvim_set_hl(0, "MarkSignHL", { link = "GruvboxBlueSign" })
vim.api.nvim_set_hl(0, "GitSignsAdd", { link = "GruvboxBlueSign" })
vim.api.nvim_set_hl(0, "GitSignsChange", { link = "GruvboxGreenSign" })
vim.api.nvim_set_hl(0, "GitSignsDelete", { link = "GruvboxRedSign" })
