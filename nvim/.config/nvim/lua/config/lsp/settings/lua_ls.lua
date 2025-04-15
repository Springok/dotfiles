return {
  settings = {
    lua_ls = {
      cmd = { '/download/lua-language-server-3.13.5-linux-arm64/bin/lua-language-server' },
      -- filetypes = { ... },
      -- capabilities = {},
      settings = {
        Lua = {
          completion = {
            callSnippet = 'Replace',
          },
          -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
          -- diagnostics = { disable = { 'missing-fields' } },
        },
      },
    },
  },
}
