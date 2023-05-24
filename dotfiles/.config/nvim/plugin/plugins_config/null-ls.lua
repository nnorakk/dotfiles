local null_ls = require("null-ls")

null_ls.setup({
    sources = {
        null_ls.builtins.formatting.isort,
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.lua_format,
        null_ls.builtins.formatting.shfmt.with({ extra_args = { "-i", "2", "-ci" }, }),
        null_ls.builtins.diagnostics.flake8,
    },
})
