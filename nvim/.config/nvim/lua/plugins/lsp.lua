return {
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      -- list of servers for mason to install
      ensure_installed = {
        "html",
        "cssls",
        "tailwindcss",
        "lua_ls",
        "eslint",
        "jsonls",
        "clojure_lsp",
        "eslint",
        "gopls",
        -- "ruby_lsp",
        "rubocop"
      },
    },
    dependencies = {
      {
        "williamboman/mason.nvim",
        opts = {
          ui = {
            icons = {
              package_installed = "✓",
              package_pending = "➜",
              package_uninstalled = "✗",
            },
          },
        },
      },
      "neovim/nvim-lspconfig",
    },
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
      ensure_installed = {
        "prettier", -- prettier formatter
        "stylua",   -- lua formatter
        "isort",    -- python formatter
        "black",    -- python formatter
        "pylint",
        "eslint_d",
      },
    },
    dependencies = {
      "williamboman/mason.nvim",
    },
  },
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
          -- diagnostics.rubocop.with({
          --   command = "bundle",
          --   args = vim.list_extend({ "exec", "rubocop" }, diagnostics.rubocop._opts.args),
          -- }),
          -- formatting.rubocop.with({
          --   command = "bundle",
          --   args = vim.list_extend({ "exec", "rubocop" }, formatting.rubocop._opts.args),
          -- }),
          diagnostics.trail_space,
          diagnostics.todo_comments,
          diagnostics.yamllint,
          diagnostics.erb_lint,
        }
      }
    end,
  }
}
