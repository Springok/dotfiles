return {
  -- LSP
  "neovim/nvim-lspconfig",   -- enable LSP
  "williamboman/mason.nvim", -- simple to use language server installer
  "williamboman/mason-lspconfig.nvim",
  "folke/trouble.nvim",
  {
    "nvimtools/none-ls.nvim",
    version = "*",
    lazy = false,
    config = function()
      local nls = require("null-ls")
      -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
      -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
      local formatting = nls.builtins.formatting
      local diagnostics = nls.builtins.diagnostics

      -- bundle, https://github.com/jose-elias-alvarez/null-ls.nvim/issues/270
      nls.setup {
        sources = {
          diagnostics.rubocop.with({
            command = "bundle",
            args = vim.list_extend({ "exec", "rubocop" }, diagnostics.rubocop._opts.args),
          }),
          formatting.rubocop.with({
            command = "bundle",
            args = vim.list_extend({ "exec", "rubocop" }, formatting.rubocop._opts.args),
          }),
          diagnostics.trail_space,
        }
      }
    end,
  }
}
