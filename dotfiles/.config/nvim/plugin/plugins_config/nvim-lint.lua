require('lint').linters_by_ft = {
    python = { 'pylint', }
}

vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
    callback = function()
        require("lint").try_lint()
    end,
})

vim.keymap.set("n", "<leader>l", function()
    require("lint").try_lint()
end, { desc = "Trigger linting for current file" })
