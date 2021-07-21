-- global options 
vim.o.clipboard = 'unnamedplus' -- forca registros * e + em yank
vim.o.foldmethod = 'indent' -- Usa folding atraves da identacao
vim.o.foldlevel = 99  -- Abre sem folding
vim.o.tabstop = 4 -- expande tabs em espacos
vim.o.softtabstop = 4 -- expande tabs em espacos
vim.o.shiftwidth = 4 -- expande tabs em espacos
vim.o.expandtab = true -- expande tabs em espacos
vim.o.number = true -- Seta line
vim.o.relativenumber = true -- Seta relativenumber
vim.o.cursorline = true -- Habilita highlight na linha atual
vim.o.splitbelow = true -- " Preferencias ao splitar janelas
vim.o.splitright = true -- " Preferencias ao splitar janelas
vim.o.hidden = true -- Permite saltar para buffers nao salvos
vim.o.showcmd = false -- Nao imprime comando na ultima linha
vim.o.termguicolors = true -- 
vim.g.colors_name = 'gruvbox'
-- vim.o.encoding = 'utf-8'  -- nao necessario, ja default
-- vim.o.background = 'dark' -- seta background, nao necessario, ja default no neovim
-- vim.o.hlsearch = true -- highlight termos buscados, nao necessario, ja default no neovim
-- vim.o.incsearch = true -- busca enquanto estiver digitando, nao necessario, ja default no neovim
-- vim.o.ignorecase = true -- ignore case em buscas /, nao necessario, ja default no neovim
-- vim.o.smartcase = true -- ignore case em buscas /, nao necessario, ja default no neovim
-- vim.o.fillchars="vert:│" -- Modifica o caracter separador vertical (U+2503, UTF-8: E2 94 83)
-- vim.o.backspace = 'indent,eol,start' -- comportamento backspace, nao necessario, ja default no neovim

--https://github.com/hrsh7th/nvim-compe
vim.o.completeopt = "menuone,noselect"

vim.cmd('highlight link CompeDocumentation NormalFloat')
vim.cmd('highlight Comment gui=italic')

require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  resolve_timeout = 800;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = {
    border = { '', '' ,'', ' ', '', '', '', ' ' }, -- the border option is the same as `|help nvim_open_win|`
    winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
    max_width = 120,
    min_width = 60,
    max_height = math.floor(vim.o.lines * 0.3),
    min_height = 1,
  };

  source = {
    path = true;
    buffer = true;
    calc = true;
    nvim_lsp = true;
    nvim_lua = true;
    vsnip = true;
    ultisnips = true;
    luasnip = true;
  };
}

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif vim.fn['vsnip#available'](1) == 1 then
    return t "<Plug>(vsnip-expand-or-jump)"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  elseif vim.fn['vsnip#jumpable'](-1) == 1 then
    return t "<Plug>(vsnip-jump-prev)"
  else
    -- If <S-Tab> is not working in your terminal, change it to <C-h>
    return t "<S-Tab>"
  end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})

-- gruvbox
--
vim.g.gruvbox_italic = 1

--- python
--  instale o server assim: pip install 'python-lsp-server[all]'
require'lspconfig'.pylsp.setup{}

-- gitsigns
require('gitsigns').setup()

-- indent-blankline.nvim
-- Modifica o caracter separador vertical (U+2503, UTF-8: E2 94 83)
vim.g.indent_blankline_char = "│"
vim.g.indent_blankline_filetype_exclude = 'text,help,vim,man'

-- telescope
require('telescope').setup{
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
      '--follow'
    },
    mappings = {
        i = {
            ["<C-s>"] = require("telescope.actions").select_horizontal,
        },
        n = {
            ["<C-s>"] = require("telescope.actions").select_horizontal,
        },
    },
    prompt_prefix = "> ",
    selection_caret = "> ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "descending",
    layout_strategy = "horizontal",
    layout_config = {
      horizontal = {
        mirror = false,
      },
      vertical = {
        mirror = false,
      },
    },
    file_sorter =  require'telescope.sorters'.get_fuzzy_file,
    file_ignore_patterns = {},
    generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
    winblend = 0,
    border = {},
    borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
    color_devicons = true,
    use_less = true,
    path_display = {},
    set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
    file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
    grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
    qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,

    -- Developer configurations: Not meant for general override
    buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker
  }
}
