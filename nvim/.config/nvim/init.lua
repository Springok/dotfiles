-- require "config.plugins"
require("config.lazy")
-- require("config.cmp")
-- require "config.lsp"
-- require "config.telescope"
-- require "config.treesitter"
-- require "config.gitsigns"
-- require "config.nvim-tree"
-- require "config.bufferline"
-- require("config.null-ls")

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

-- =================
--      Plugins
-- =================

-- Vista, not working, not sure why...
vim.g.vista_executive_for = {
	clj = "nvim_lsp",
	cljs = "nvim_lsp",
}

-- rainbow_delimiters, This module contains a number of default definitions
local rainbow_delimiters = require("rainbow-delimiters")

vim.g.rainbow_delimiters = {
	strategy = {
		[""] = rainbow_delimiters.strategy["global"],
		vim = rainbow_delimiters.strategy["local"],
	},
	query = {
		[""] = "rainbow-delimiters",
		lua = "rainbow-blocks",
	},
	highlight = {
		"RainbowDelimiterRed",
		"RainbowDelimiterYellow",
		"RainbowDelimiterBlue",
		"RainbowDelimiterOrange",
		"RainbowDelimiterGreen",
		"RainbowDelimiterViolet",
		"RainbowDelimiterCyan",
	},
}

-- TreeSJ
local tsj = require("treesj")

tsj.setup({
	---If line after join will be longer than max value,
	---@type number If line after join will be longer than max value, node will not be formatted
	max_join_length = 400,
})
