-- null ls
local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local formatting  = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

-- bundle, https://github.com/jose-elias-alvarez/null-ls.nvim/issues/270
null_ls.setup({
  sources = {
    diagnostics.rubocop.with({
      command = "bundle",
      args = vim.list_extend({ "exec", "rubocop" }, diagnostics.rubocop._opts.args)
    }),
    formatting.rubocop.with({
      command = "bundle",
      args = vim.list_extend({ "exec", "rubocop" }, formatting.rubocop._opts.args)
    }),
    diagnostics.trail_space,
    -- clojure lsp supported by default
    -- diagnostics.clj_kondo,
    -- formatting.cljstyle,
  },
})
