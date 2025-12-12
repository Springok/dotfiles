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

  opts.desc = "Show documentation for what is under cursor"
  keymap("n", "K", vim.lsp.buf.hover, opts)

  opts.desc = "Go to declaration"
  keymap("n", "gD", vim.lsp.buf.declaration, opts)

  opts.desc = "Show LSP definitions"
  keymap("n", "gd", vim.lsp.buf.definition, opts)

  opts.desc = "Show LSP implementations"
  keymap("n", "<localleader>li", "<cmd>lua require('telescope.builtin').lsp_implementations()<cr>", opts)

  opts.desc = "Show LSP references"
  keymap("n", "<localleader>lr", "<cmd>lua require('telescope.builtin').lsp_references()<cr>", opts)

  opts.desc = "Show Type definition"
  keymap("n", "<localleader>lt", vim.lsp.buf.type_definition, opts)

  opts.desc = "Smart rename"
  keymap("n", "<localleader>ln", vim.lsp.buf.rename, opts)

  opts.desc = "Signature Help"
  keymap("n", "<localleader>lh", vim.lsp.buf.signature_help, opts)

  opts.desc = "See available code actions"
  keymap({ "v", "n" }, "<localleader>la", vim.lsp.buf.code_action, opts)

  opts.desc = "Formatting"
  keymap("n", "<localleader>lf", vim.lsp.buf.format, opts)

  vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
end

local on_attach = function(client, bufnr)
  lsp_keymaps(bufnr)
  lsp_highlight_document(client)
end

require("mason").setup {
  registries = {
    "github:mason-org/mason-registry@2024-12-30-ripe-blouse",
  },
}

local registry = require 'mason-registry'

-- -- Try to get the lua-language-server package
-- local ok, lua_ls = pcall(registry.get_package, "lua-language-server")
-- if not ok then
--   vim.notify("Failed to load lua-language-server from Mason registry", vim.log.levels.ERROR)
--   return
-- end

-- Override the source version
-- lua_ls.spec.source.id = "pkg:github/LuaLS/lua-language-server@3.13.5"

for _, package_name in ipairs { 'lua-language-server', 'stylua' } do
  local ok, package = pcall(function()
    return registry.get_package(package_name)
  end)
  if ok and (not package:is_installed()) then
    -- Override the installation options
    package:install {
      target = 'linux_arm64_gnu', -- Specify the target platform manually if supported
    }
  end
end

local capabilities = require('blink.cmp').get_lsp_capabilities(capabilities)

-- local capabilities = require("cmp_nvim_lsp").default_capabilities()
local servers = { "jsonls", "lua_ls", "clojure_lsp", "eslint", "gopls", "ruby_lsp", "rubocop" }

require("mason-lspconfig").setup {
  ensure_installed = servers,
  automatic_installation = false,
  handlers = {
    function(server_name)
      local opts = {
        on_attach = on_attach,
        capabilities = capabilities,
      }
      local has_custom_opts, server_custom_opts = pcall(require, "config.lsp.settings." .. server_name)
      if has_custom_opts then
        opts = vim.tbl_deep_extend("force", server_custom_opts, opts)
      end
      require('lspconfig')[server_name].setup(opts)
    end,
  },
}
