-- mappings.lua
require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Angular specific mappings
map("n", "<leader>ag", "<cmd>AngularGoToComponent<cr>", { desc = "Angular: Go to component" })
map("n", "<leader>as", "<cmd>AngularSwitchTemplate<cr>", { desc = "Angular: Switch between template and component" })

-- Phoenix specific mappings
map("n", "<leader>pm", "<cmd>MixFormat<cr>", { desc = "Phoenix: Format with Mix" })
map("n", "<leader>pt", "<cmd>MixTest<cr>", { desc = "Phoenix: Run tests" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
