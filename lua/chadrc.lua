-- chadrc.lua
---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "rxyhn",
  hl_override = {
    -- Folders - Enhanced hierarchy with Catppuccin colors
    NvimTreeFolderName = { fg = "#89b4fa", bold = true }, -- Catppuccin blue
    NvimTreeOpenedFolderName = { fg = "#89b4fa", bold = true },
    NvimTreeEmptyFolderName = { fg = "#89b4fa", bold = true },
    NvimTreeIndentMarker = { fg = "#6c7086" },            -- Subtle indent guides
    NvimTreeRootFolder = { fg = "#94e2d5", bold = true }, -- Teal for root

    -- Core UI - Optimized contrast
    NvimTreeNormal = { fg = "#cdd6f4" },      -- Text
    NvimTreeEndOfBuffer = { fg = "#1e1e2e" }, -- Dark background
    NvimTreeCursorLine = { bg = "#313244" },  -- Selection
    NvimTreeVertSplit = { fg = "#313244" },   -- Splits

    -- Git Integration - Catppuccin palette
    NvimTreeGitNew = { fg = "#a6e3a1" },     -- Green
    NvimTreeGitDirty = { fg = "#f9e2af" },   -- Yellow
    NvimTreeGitStaged = { fg = "#94e2d5" },  -- Teal
    NvimTreeGitDeleted = { fg = "#f38ba8" }, -- Red
    NvimTreeGitMerge = { fg = "#cba6f7" },   -- Mauve
    NvimTreeGitRenamed = { fg = "#89b4fa" }, -- Blue
    NvimTreeGitIgnored = { fg = "#6c7086" }, -- Subtle gray

    -- Error States - Clear indicators
    NvimTreeLspDiagnosticsError = { fg = "#f38ba8" },       -- Red
    NvimTreeLspDiagnosticsWarning = { fg = "#f9e2af" },     -- Yellow
    NvimTreeLspDiagnosticsInformation = { fg = "#89b4fa" }, -- Blue
    NvimTreeLspDiagnosticsHint = { fg = "#a6e3a1" },        -- Green

    -- File Types - Enhanced hierarchy
    NvimTreeSpecialFile = { fg = "#cba6f7", bold = true }, -- Mauve
    NvimTreeSymlink = { fg = "#f5c2e7" },                  -- Pink
    NvimTreeImageFile = { fg = "#f5c2e7" },                -- Pink
    NvimTreeExecFile = { fg = "#a6e3a1", bold = true },    -- Green

    -- Extra File Types
    NvimTreeJavaScriptFile = { fg = "#f9e2af" }, -- Yellow
    NvimTreeMarkdownFile = { fg = "#94e2d5" },   -- Teal
    NvimTreePythonFile = { fg = "#89b4fa" },     -- Blue
    NvimTreeRustFile = { fg = "#f38ba8" },       -- Red
  },
}
-- Your existing theme configuration
-- All mappings consolidated
M.mappings = {
  -- Normal mode mappings
  n = {
    -- LSP related mappings
    ["gD"] = {
      function()
        vim.lsp.buf.declaration()
      end,
      "LSP declaration",
    },
    ["gd"] = {
      function()
        vim.lsp.buf.definition()
      end,
      "LSP definition",
    },
    ["K"] = {
      function()
        vim.lsp.buf.hover()
      end,
      "LSP hover info", -- Shows documentation
    },
    ["gi"] = {
      function()
        vim.lsp.buf.implementation()
      end,
      "LSP implementation",
    },
    ["<leader>ls"] = {
      function()
        vim.lsp.buf.signature_help()
      end,
      "LSP signature help", -- Show function signature
    },
    ["<leader>D"] = {
      function()
        vim.lsp.buf.type_definition()
      end,
      "LSP type definition",
    },
    ["<leader>ra"] = {
      function()
        vim.lsp.buf.rename()
      end,
      "LSP rename symbol", -- Rename variables/functions
    },
    ["<leader>ca"] = {
      function()
        vim.lsp.buf.code_action()
      end,
      "LSP code action", -- Show available code actions
    },
    ["gr"] = {
      function()
        vim.lsp.buf.references()
      end,
      "LSP find references", -- Find all references
    },
    ["<leader>f"] = {
      function()
        vim.diagnostic.open_float({ border = "rounded" })
      end,
      "Floating diagnostic", -- Show error in floating window
    },
    ["[d"] = {
      function()
        vim.diagnostic.goto_prev({ float = { border = "rounded" } })
      end,
      "Previous diagnostic", -- Jump to previous error/warning
    },
    ["]d"] = {
      function()
        vim.diagnostic.goto_next({ float = { border = "rounded" } })
      end,
      "Next diagnostic", -- Jump to next error/warning
    },
    ["<leader>q"] = {
      function()
        vim.diagnostic.setloclist()
      end,
      "Set diagnostic list",
    },

    -- Workspace folder management
    ["<leader>wa"] = {
      function()
        vim.lsp.buf.add_workspace_folder()
      end,
      "Add workspace folder",
    },
    ["<leader>wr"] = {
      function()
        vim.lsp.buf.remove_workspace_folder()
      end,
      "Remove workspace folder",
    },
    ["<leader>wl"] = {
      function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end,
      "List workspace folders",
    },

    -- Copilot commands in normal mode
    ["<leader>cp"] = {
      function()
        vim.cmd("Copilot panel")
      end,
      "Open Copilot suggestion panel",
    },
    ["<leader>ce"] = {
      function()
        vim.cmd("Copilot enable")
      end,
      "Enable Copilot",
    },
    ["<leader>cd"] = {
      function()
        vim.cmd("Copilot disable")
      end,
      "Disable Copilot",
    },
  },

  -- Insert mode mappings
  i = {
    -- Copilot mappings
    ["<Tab>"] = {
      function()
        if require("copilot.suggestion").is_visible() then
          require("copilot.suggestion").accept()
        else
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
        end
      end,
      "Accept Copilot suggestion or Tab",
    },
    ["<D-]>"] = { -- Cmd+] on macOS
      function()
        require("copilot.suggestion").next()
      end,
      "Next Copilot suggestion",
    },
    ["<D-[>"] = { -- Cmd+[ on macOS
      function()
        require("copilot.suggestion").prev()
      end,
      "Previous Copilot suggestion",
    },
    ["<C-]>"] = { -- Ctrl+]
      function()
        require("copilot.suggestion").dismiss()
      end,
      "Dismiss Copilot suggestion",
    },
    ["<C-l>"] = { -- Ctrl+l
      function()
        require("copilot.suggestion").accept_word()
      end,
      "Accept Copilot word",
    },
    ["<C-j>"] = { -- Ctrl+j
      function()
        require("copilot.suggestion").accept_line()
      end,
      "Accept Copilot line",
    },
  },
}

return M
