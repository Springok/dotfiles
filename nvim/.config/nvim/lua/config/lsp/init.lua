local lspconfig = require("lspconfig")

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = "rounded",
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = "rounded",
})

local function lsp_highlight_document(client)
  -- Set autocommands conditional on server_capabilities
  if client.server_capabilities.document_highlight then
    vim.api.nvim_exec2(
      [[
      augroup lsp_document_highlight
      autocmd! * <buffer>
      autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
      autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
      ]],
      { output = false }
    )
  end
end

local function lsp_keymaps(bufnr)
  local keymap = vim.keymap.set
  local opts = { noremap = true, silent = true, buffer = bufnr }

  keymap("n", "K", vim.lsp.buf.hover, opts)
  keymap("n", "gD", vim.lsp.buf.declaration, opts)
  keymap("n", "gd", vim.lsp.buf.definition, opts)
  keymap("n", "<localleader>li", "<cmd>lua require('telescope.builtin').lsp_implementations()<cr>", opts)
  keymap("n", "<localleader>lr", "<cmd>lua require('telescope.builtin').lsp_references()<cr>", opts)
  keymap("n", "<localleader>lt", vim.lsp.buf.type_definition, opts)
  keymap("n", "<localleader>lh", vim.lsp.buf.signature_help, opts)
  keymap("n", "<localleader>ln", vim.lsp.buf.rename, opts)
  keymap({ "v", "n" }, "<localleader>la", vim.lsp.buf.code_action, opts)
  keymap("n", "<localleader>lf", vim.lsp.buf.format, opts)

  vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
end

local on_attach = function(client, bufnr)
  lsp_keymaps(bufnr)
  lsp_highlight_document(client)
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()

local servers = { "jsonls", "lua_ls", "clojure_lsp", "tailwindcss", "eslint", "ruby_lsp" }

require("mason").setup()
require("mason-lspconfig").setup {
  ensure_installed = servers
}

for _, server in pairs(servers) do
  local opts = {
    on_attach = on_attach,
    capabilities = capabilities,
  }
  local has_custom_opts, server_custom_opts = pcall(require, "config.lsp.settings." .. server)
  if has_custom_opts then
    opts = vim.tbl_deep_extend("force", server_custom_opts, opts)
  end
  lspconfig[server].setup(opts)
end
