-- configs/lspconfig.lua
-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()
local lspconfig = require "lspconfig"
local nvlsp = require "nvchad.configs.lspconfig"


-- Define all servers we want to configure
local servers = {
  "html",
  "cssls",
  "lua_ls",
  "tailwindcss",
}

-- Default LSP configurations
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

-- TypeScript configuration - Fixed server name from ts_ls to tsserver
lspconfig.ts_ls.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  init_options = {
    preferences = {
      disableSuggestions = false,
      includeInlayParameterNameHints = 'all',
      includeInlayParameterNameHintsWhenArgumentMatchesName = true,
      includeInlayFunctionParameterTypeHints = true,
      includeInlayVariableTypeHints = true,
      includeInlayPropertyDeclarationTypeHints = true,
      includeInlayFunctionLikeReturnTypeHints = true,
      includeInlayEnumMemberValueHints = true,
    },
  },
  filetypes = {
    "typescript",
    "javascript",
    "javascriptreact",
    "typescriptreact",
    "typescript.tsx"
  },
  commands = {
    TypescriptOrganizeImports = {
      function()
        vim.lsp.buf.execute_command({
          command = "_typescript.organizeImports",
          arguments = { vim.api.nvim_buf_get_name(0) },
        })
      end,
      description = "Organize Imports"
    }
  }
}

-- Rest of your configurations remain the same
-- Golang configuration
lspconfig.gopls.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
      gofumpt = true,
    },
  },
}

-- Lua configuration
lspconfig.lua_ls.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
          [vim.fn.stdpath("config") .. "/lua"] = true,
        },
        maxPreload = 2000,
        preloadFileSize = 50000,
      },
    },
  },
}

-- ESLint configuration
lspconfig.eslint.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
}

-- Tailwind CSS configuration
lspconfig.tailwindcss.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  settings = {
    tailwindCSS = {
      classAttributes = { "class", "className", "classList", "ngClass" },
      lint = {
        cssConflict = "warning",
        invalidApply = "error",
        invalidConfigPath = "error",
        invalidScreen = "error",
        invalidTailwindDirective = "error",
        invalidVariant = "error",
        recommendedVariantOrder = "warning"
      },
      validate = true,
      experimental = {
        classRegex = {
          "tw`([^`]*)",
          'tw="([^"]*)',
          'tw={"([^"}]*)',
          "tw\\.\\w+`([^`]*)",
          "tw\\(.*?\\)`([^`]*)",
          "cn`([^`]*)",
          'cn="([^"]*)',
          'cn={"([^"}]*)',
          "cn\\(.*?\\)`([^`]*)",
          "tv`([^`]*)",
          'tv="([^"]*)',
          'tv={"([^"}]*)',
          "tv\\(.*?\\)`([^`]*)",
        },
      },
    },
  },
  filetypes = {
    "html",
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "css",
    "scss",
    "heex",         -- Added HEEX support
    "eex",          -- Added EEx support
    "elixir",       -- Added Elixir support
    "html-eex",     -- Added HTML-EEx support
    "phoenix-heex", -- Added Phoenix HEEX support
  },
  init_options = {
    userLanguages = {
      eelixir = "html-eex",
      eruby = "erb",
      heex = "html",            -- Treat HEEX as HTML
      "phoenix-heex" == "html", -- Treat Phoenix HEEX as HTML
    }
  }
}

-- Elixir configuration
lspconfig.elixirls.setup {
  -- Update the cmd to use the correct path
  cmd = { vim.fn.expand("$HOME") .. "/.local/share/nvim/mason/bin/elixir-ls" }, -- Adjust path if needed
  on_attach = nvlsp.on_attach,
  capabilities = nvlsp.capabilities,
  settings = {
    elixirLS = {
      -- Start with dialyzer disabled - you can enable it later
      dialyzerEnabled = false,
      fetchDeps = false,
      enableTestLenses = false,
      suggestSpecs = false,
    },
  },
  filetypes = { "elixir", "eex", "heex", "surface" },
}
