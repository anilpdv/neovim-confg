-- Ensure folds are open by default
vim.wo.foldmethod = "manual"
vim.wo.foldlevel = 99

-- Set up Rust-specific keymaps
local bufnr = vim.api.nvim_get_current_buf()
vim.keymap.set("n", "<leader>a", function()
  vim.cmd("RustLsp codeAction")
end, { silent = true, buffer = bufnr, desc = "Rust: Code Action" })

vim.keymap.set("n", "K", function()
  vim.cmd("RustLsp hover actions")
end, { silent = true, buffer = bufnr, desc = "Rust: Hover Actions" })