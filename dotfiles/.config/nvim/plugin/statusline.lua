-- temas agradaveis
local themes = {  'molokai','seoul256', 'Tomorrow_Night', 'wombat', 'jellybeans', 'gruvbox' }

-- necessario para gerar aleatoridade
math.randomseed(os.time())
-- captura um dos temas aleatoriamente
local random_theme = themes[math.random(1,6)]

-- local function GitInformation()
--    -- return vim.b.gitsigns_head 
--    if not vim.b.gitsigns_head then
--        return 'gitsigns_head nao existe'
--    else
--        return ("gitsigns_head igual a " .. vim.b.gitsigns_head )
--        -- print("gitsigns_head igual a ")
--    end
-- end

-- -- print('Hello Wold')
-- local a = GitInformation()
-- print(a)
--
-- obrigado
-- https://github.com/jens1205/dotfiles/blob/c534a34d08133084348cabf8b073db5cae6d975c/nvim/.config/nvim/lua/lightline_config.lua
vim.cmd([[
function! GitInformation()
    if !empty(gitbranch#name()) 
        return ' ' . gitbranch#name()
    else
        return ''
    endif
endfunction
]])

-- definir statusline
vim.g.lightline = {
    colorscheme = random_theme,
    active = {
        left = { { 'mode', 'paste' }, { 'readonly', 'filename', 'modified', 'gitbranch' } },
        right = {{'lineinfo'}, {'percent'}, {'filetype'}}
    },
    inactive = {
        left = { { 'absolutepath' } },
    },
    component_function = {
        gitbranch = 'gitbranch#name' 
        -- gitbranch = 'GitInformation' 
    }
}
