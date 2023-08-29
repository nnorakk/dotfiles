-- configura colorscheme gruvbox se existir
local status_ok, _ = pcall(vim.cmd.colorscheme, "gruvbox")
if not status_ok then
    return
end

vim.cmd('hi InactiveWindow guibg=#333333')
vim.cmd('hi link ActiveWindow Normal')
