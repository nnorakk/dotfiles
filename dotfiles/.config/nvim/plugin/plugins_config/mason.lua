require("mason").setup()

require("mason-lspconfig").setup {
    ensure_installed = { "pylsp" },
}

-- por alguma razao esse formato nao funciona nesse plugin
-- require("mason-tool-installer").setup()
require('mason-tool-installer').setup {
    ensure_installed = {
        "pylint",
        "isort",
        "black",
        "ansible-lint",
        "lua_ls",
        "bashls",
        "ansiblels",
    },
}

require('mason-update-all').setup()
