-- ================
--      Config
-- ================
vim.g.mapleader = ","
-- vim.g.maplocalleader = " "

require("config.options")
require("config.autocmds")
require("config.lazy")
require("config.keymaps")
require("config.lsp")

-- ================
--      Theme
-- ================
-- vim.g.onedark_config = { style = "warmer" }
-- vim.cmd [[colorscheme onedark]]
-- vim.g.vscode_style = "dark"
-- vim.cmd [[colorscheme vscode]]
-- vim.cmd [[colorscheme tokyonight]]
-- vim.g.material_style = "darker"
-- vim.cmd [[colorscheme material]]
vim.cmd([[colorscheme catppuccin]])
