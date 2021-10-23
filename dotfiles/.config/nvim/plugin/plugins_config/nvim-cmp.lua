local cmp = require 'cmp'

local lspkind = require('lspkind')

cmp.setup {
  snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
    end,
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
 
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'buffer', keyword_length = 5 }, -- apresenta sugestoes depois de 5 caracteres
    { name = 'path' },
    { name = 'vsnip' },
  },
  formatting = {
      format = lspkind.cmp_format({
          with_text = false,
          maxwidth = 50,
          menu = {
              buffer = "[buf]",
              nvim_lsp = "[LSP]",
              path = "[path]",
              vsnip = "[snip]",
          }
      })
  }
}
