return {
	"wbthomason/packer.nvim", -- Packer can manage itself
	"nvim-lua/popup.nvim", -- An implementation of the Popup API from vim in Neovim
	"nvim-lua/plenary.nvim", -- Useful lua functions used ny lots of plugins
	"kyazdani42/nvim-tree.lua",
	{ "akinsho/bufferline.nvim", version = "*" },

	"lewis6991/impatient.nvim",

	-- "ssh://git@gitlab.abagile.com:7788/chiao.chuang/vim-abagile.git",

	{
		"Wansmer/treesj",
		dependecies = { "nvim-treesitter/nvim-treesitter" },
	},

	-- search and replace
	"nvim-pack/nvim-spectre",

	-- Remove spacing
	"McAuleyPenney/tidy.nvim",

	-- Navigation
	"tpope/vim-projectionist",
	"tpope/vim-unimpaired",

	-- Indent
	"austintaylor/vim-indentobject",
	"lukas-reineke/indent-blankline.nvim",

	-- Commenting
	-- 'tomtom/tcomment_vim'
	{
		"numToStr/Comment.nvim",
		opts = {
			-- add any options here
		},
		lazy = false,
	},

	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
	},
	"nvim-treesitter/playground",

	-- highlight parenthesis
	"HiPhish/rainbow-delimiters.nvim",
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
		-- use opts = {} for passing setup options
		-- this is equalent to setup({}) function
	},

	-- CSS #fff
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	},

	-- cmp plugins
	"hrsh7th/nvim-cmp", -- The completion plugin
	"hrsh7th/cmp-buffer", -- buffer completions
	"hrsh7th/cmp-path", -- path completions
	"hrsh7th/cmp-cmdline", -- cmdline completions
	"saadparwaiz1/cmp_luasnip", -- snippet completions
	"hrsh7th/cmp-nvim-lsp",
	"PaterJason/cmp-conjure",

	-- snippets
	"L3MON4D3/LuaSnip", --snippet engine
	"rafamadriz/friendly-snippets",

	-- LSP
	"neovim/nvim-lspconfig", -- enable LSP
	"williamboman/mason.nvim", -- simple to use language server installer
	"williamboman/mason-lspconfig.nvim",
	"nvimtools/none-ls.nvim", -- ale alternative
	"folke/trouble.nvim",

	-- Tagbar alternative
	"liuchengxu/vista.vim",

	-- Telescope
	"nvim-telescope/telescope.nvim",
	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	{ "nvim-telescope/telescope-ui-select.nvim" },

	-- Git
	"lewis6991/gitsigns.nvim",
	"tpope/vim-fugitive", -- Git commands
	"f-person/git-blame.nvim", -- Git commands

	-- Ruby
	"tpope/vim-rails", -- only load when opening Ruby file
	"tpope/vim-bundler",
	"kchmck/vim-coffee-script",
	"slim-template/vim-slim",

	"tpope/vim-repeat",
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
	},
	"tpope/vim-endwise",
	"junegunn/vim-easy-align",
	"pedrohdz/vim-yaml-folds",

	"christoomey/vim-tmux-navigator",
	"christoomey/vim-tmux-runner",
	"vim-test/vim-test",

	{ "Mofiqul/vscode.nvim", branch = "main" },
	"navarasu/onedark.nvim",
	"folke/tokyonight.nvim",
	{ "marko-cerovac/material.nvim", branch = "main" },
	--"projekt0n/github-nvim-theme",
	{ "catppuccin/nvim", name = "catppuccin" },

	-- Clojure, Lisp
	"gpanders/nvim-parinfer",
	"guns/vim-sexp",
	"tpope/vim-sexp-mappings-for-regular-people",
	"Olical/conjure",
	"clojure-vim/vim-jack-in",
}
