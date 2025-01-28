local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    -- Golang
    go = { "gofumpt", "goimports" },

    -- JavaScript/TypeScript
    javascript = { "prettier" },
    typescript = { "prettier" },
    javascriptreact = { "prettier" },
    typescriptreact = { "prettier" },

    -- Web
    html = { "prettier" },
    css = { "prettier" },
    json = { "prettier" },
    yaml = { "prettier" },
    markdown = { "prettier" },

    -- Elixir
    elixir = { "mix" }, -- Elixir formatter
  },

  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

return options
