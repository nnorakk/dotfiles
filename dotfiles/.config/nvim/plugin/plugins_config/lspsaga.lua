require('lspsaga').setup({})

local colors = {
   -- normal_bg = '#1d1536',
   normal_bg = "#282828",
   title_bg = '#afd700',
   red = '#e95678',
   magenta = '#b33076',
   orange = '#FF8700',                                                                                yellow = '#f7bb3b',
   green = '#afd700',
   cyan = '#36d0e0',
   blue = '#61afef',
   purple = '#CBA6F7',
   white = '#d1d4cf',
   black = '#1c1c19',
   gray = '#6e6b6b',
   fg = '#f2f2bf',
}

-- vim.api.nvim_set_hl(0, "TitleString" , { bg = colors.title_bg, fg = colors.black, bold = true })
-- vim.api.nvim_set_hl(0, "TitleSymbol" , { bg = colors.normal_bg, fg = colors.title_bg })
-- vim.api.nvim_set_hl(0, "TitleIcon" , { bg = colors.title_bg, fg = colors.red })
vim.api.nvim_set_hl(0, "SagaBorder" , { bg = colors.normal_bg, fg = colors.blue })
vim.api.nvim_set_hl(0, "SagaNormal" , { bg = colors.normal_bg })
-- vim.api.nvim_set_hl(0, "SagaExpand" , { fg = colors.red })
-- vim.api.nvim_set_hl(0, "SagaCollapse" , { fg = colors.red })
-- vim.api.nvim_set_hl(0, "SagaBeacon" , { bg = colors.magenta })

local keymap = vim.keymap.set
---- Lsp finder find the symbol definition implement reference
---- if there is no implement it will hide
---- when you use action in finder like open vsplit then you can
---- use <C-t> to jump back
----
keymap("n", "<Leader>gh", "<cmd>Lspsaga lsp_finder<CR>")

---- Code action
--keymap({"n","v"}, "<leader>ca", "<cmd>Lspsaga code_action<CR>")

---- Rename
keymap("n", "<Leader>gr", "<cmd>Lspsaga rename<CR>")  -- TODO verificar pq ja existe outro atalho para essa combinacao

---- Peek Definition
---- you can edit the definition file in this float window
---- also support open/vsplit/etc operation check definition_action_keys
---- support tagstack C-t jump back
--keymap("n", "gd", "<cmd>Lspsaga peek_definition<CR>")

---- Go to Definition
--keymap("n","gd", "<cmd>Lspsaga goto_definition<CR>")

---- Show line diagnostics you can pass argument ++unfocus to make
---- show_line_diagnostics float window unfocus
--keymap("n", "<leader>sl", "<cmd>Lspsaga show_line_diagnostics<CR>")

---- Show cursor diagnostic
---- also like show_line_diagnostics  support pass ++unfocus
--keymap("n", "<leader>sc", "<cmd>Lspsaga show_cursor_diagnostics<CR>")

---- Show buffer diagnostic
--keymap("n", "<leader>sb", "<cmd>Lspsaga show_buf_diagnostics<CR>")

---- Diagnostic jump can use `<c-o>` to jump back
--keymap("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
--keymap("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>")

---- Diagnostic jump with filter like Only jump to error
--keymap("n", "[E", function()
--  require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
--end)
--keymap("n", "]E", function()
--  require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
--end)

---- Toggle Outline
--keymap("n","<leader>o", "<cmd>Lspsaga outline<CR>")

---- Hover Doc
---- if there has no hover will have a notify no information available
---- to disable it just Lspsaga hover_doc ++quiet
---- press twice it will jump into hover window
--keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>")
---- if you want keep hover window in right top you can use ++keep arg
---- notice if you use hover with ++keep you press this keymap it will
---- close the hover window .if you want jump to hover window must use
---- wincmd command <C-w>w
--keymap("n", "K", "<cmd>Lspsaga hover_doc ++keep<CR>")

---- Callhierarchy
--keymap("n", "<Leader>ci", "<cmd>Lspsaga incoming_calls<CR>")
--keymap("n", "<Leader>co", "<cmd>Lspsaga outgoing_calls<CR>")

---- Float terminal
--keymap({"n", "t"}, "<A-d>", "<cmd>Lspsaga term_toggle<CR>")
        local colorsi = {
          --float window normal bakcground color
          normal_bg = '#ebdbb2',
          --title background color
          title_bg = '#ebdbb2',
          red = '#ebdbb2',
          magenta = '#ebdbb2',
          orange = '#ebddb2',
          yellow = '#ebddb2',
          green = '#ebddb2',
          cyan = '#ebdbb2',
          blue = '#ebdbb2',
          purple = '#ebdbb2',
          white = '#ebdbb2',
          black = '#ebdbb2',
        }

local colors = {
    red = '#e95678',
    magenta = '#b33076',
    orange = '#FF8700',
    yellow = '#f7bb3b',
    green = '#afd700',
    cyan = '#36d0e0',
    blue = '#61afef',
    purple = '#CBA6F7',
    white = '#d1d4cf',
    black = '#1c1c19',
    gray = '#6e6b6b',
    fg = '#f2f2bf',
}

-- general
-- TitleString = { bg = colors.title_bg, fg = colors.black, bold = true },
-- TitleSymbol = { bg = colors.normal_bg, fg = colors.title_bg },
-- TitleIcon = { bg = colors.title_bg, fg = colors.red },
-- SagaBorder = { bg = colors.normal_bg },
-- SagaExpand = { fg = colors.red },
-- SagaCollapse = { fg = colors.red },
-- SagaBeacon = { bg = colors.magenta },
-- code action
-- ActionPreviewNormal = { link = 'SagaBorder' },
-- ActionPreviewBorder = { link = 'SagaBorder' },
-- ActionPreviewTitle = { fg = colors.purple, bg = colors.normal_bg },
-- CodeActionNormal = { link = 'SagaBorder' },
-- CodeActionBorder = { link = 'SagaBorder' },
-- CodeActionText = { fg = colors.yellow },
-- CodeActionConceal = { fg = colors.green },
-- finder
-- FinderSelection = { fg = colors.cyan, bold = true },
-- FinderFileName = { fg = colors.white },
-- FinderCount = { link = 'Title' },
-- FinderIcon = { fg = colors.cyan },
-- FinderType = { fg = colors.purple },
--finder spinner
-- FinderSpinnerTitle = { fg = colors.magenta, bold = true },
-- FinderSpinner = { fg = colors.magenta, bold = true },
-- FinderPreviewSearch = { link = 'Search' },
-- FinderVirtText = { fg = colors.red },
-- FinderNormal = { link = 'SagaBorder' },
-- FinderBorder = { link = 'SagaBorder' },
-- FinderPreviewBorder = { link = 'SagaBorder' },
-- definition
-- DefinitionBorder = { link = 'SagaBorder' },
-- DefinitionNormal = { link = 'SagaBorder' },
-- DefinitionSearch = { link = 'Search' },
-- hover
-- HoverNormal = { link = 'SagaBorder' },
-- HoverBorder = { link = 'SagaBorder' },
-- rename
-- RenameBorder = { link = 'SagaBorder' },
-- RenameNormal = { fg = colors.orange, bg = colors.normal_bg },
-- RenameMatch = { link = 'Search' },
-- vim.api.nvim_set_hl(0, 'RenameBorder', { fg = "#ffffff", bg = "#333333" })
-- vim.api.nvim_set_hl(0, 'RenameNormal', { fg = "#ffffff", bg = "#333333" })
-- vim.api.nvim_set_hl(0, 'RenameMatch', { fg = "#ffffff", bg = "#333333" })
-- diagnostic
-- DiagnosticSource = { fg = 'gray' },
-- DiagnosticNormal = { link = 'SagaBorder' },
-- DiagnosticBorder = { link = 'SagaBorder' },
-- DiagnosticErrorBorder = { link = 'SagaBorder' },
-- DiagnosticWarnBorder = { link = 'SagaBorder' },
-- DiagnosticHintBorder = { link = 'SagaBorder' },
-- DiagnosticInfoBorder = { link = 'SagaBorder' },
-- DiagnosticPos = { fg = colors.gray },
-- DiagnosticWord = { fg = colors.fg },
-- Call Hierachry
-- CallHierarchyNormal = { link = 'SagaBorder' },
-- CallHierarchyBorder = { link = 'SagaBorder' },
-- CallHierarchyIcon = { fg = colors.purple },
-- CallHierarchyTitle = { fg = colors.red },
-- lightbulb
-- LspSagaLightBulb = { link = 'DiagnosticSignHint' },
-- shadow
-- SagaShadow = { bg = colors.black },
-- Outline
-- OutlineIndent = { fg = colors.magenta },
-- OutlinePreviewBorder = { link = 'SagaBorder' },
-- OutlinePreviewNormal = { link = 'SagaBorder' },
-- Float term
-- TerminalBorder = { link = 'SagaBorder' },
-- TerminalNormal = { link = 'SagaBorder' },

