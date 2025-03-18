vim.g.rustaceanvim = {
  lsp = {
    server = {
      default_settings = {
        ["rust-analyzer"] = {
          cargo = { allFeatures = true },
          procMacro = { enable = true },
        },
      },
    },
  },
  -- Optionally add additional tools or dap configuration here if needed.
}