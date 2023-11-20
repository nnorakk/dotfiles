local cmp = require('cmp')
local ls = require("luasnip")
local lspkind = require('lspkind')

-- carrega snippets friendly-snippets
require('luasnip.loaders.from_vscode').lazy_load()

-- carrega custons snippets desse diretorio '~/.vsnip'
require("luasnip.loaders.from_lua").load({ paths = "~/.vsnip/" })

-- config luasnip plugin
ls.config.set_config({ -- Setting LuaSnip config
    -- Enable autotriggered snippets
    enable_autosnippets = true,
})

-- config cmp plugin
cmp.setup {
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
            -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        end,
    },
    window = {
        -- completion = cmp.config.window.bordered(),
        -- documentation = cmp.config.window.bordered(),
    },
    mapping = {
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
        ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' }),
        ["<S-Tab>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'buffer',  keyword_length = 5 }, -- apresenta sugestoes depois de 5 caracteres
        { name = 'luasnip' },
        { name = 'path' },
        -- { name = 'vsnip' },
    },
    formatting = {
        format = lspkind.cmp_format({
            with_text = false,
            maxwidth = 50,
            mode = 'symbol',
            menu = {
                buffer = "[buf]",
                nvim_lsp = "[LSP]",
                luasnip = "[snip]",
                path = "[path]",
                -- vsnip = "[snip]",
            }
        })
    }
}

-- luasnip atalhos
vim.keymap.set({ "i" }, "<C-K>", function() ls.expand() end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-j>", function() ls.jump(1) end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-k>", function() ls.jump(-1) end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-n>", function() ls.change_choice(1) end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-p>", function() ls.change_choice(-1) end, { silent = true })

vim.keymap.set({ "i", "s" }, "<C-e>", function()
    if ls.choice_active() then
        ls.change_choice(1)
    end
end, { silent = true })


-- from: https://github.com/bluz71/dotfiles/blob/master/vim/lua/vsnip-config.lua
-- local g = vim.g
-- local fn = vim.fn
-- local map = vim.api.nvim_set_keymap

-- -- g.vsnip_snippet_dir = fn.expand('~/dotfiles/vim/vsnip')

-- local opts = { expr = true, silent = true }
-- map('i', '<C-j>', 'vsnip#available(1) ? "<Plug>(vsnip-expand-or-jump)" : "<C-j>"', opts)
-- map('i', '<C-k>', 'vsnip#jumpable(-1) ? "<Plug>(vsnip-jump-prev)" : "<C-k>"', opts)

-- local opts = { noremap = true, silent = true }
-- -- Insert mode snippet completion mapping - '<Control-s>'
-- map('i', '<C-s>', '<C-r>=snippets#Complete()<CR>', opts)
