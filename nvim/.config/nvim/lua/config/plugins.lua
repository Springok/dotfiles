local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
-- vim.cmd [[
--   augroup packer_user_config
--     autocmd!
--     autocmd BufWritePost plugins.lua source <afile> | PackerSync
--   augroup end
-- ]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

return packer.startup(function()
  use 'wbthomason/packer.nvim' -- Packer can manage itself
  use "nvim-lua/popup.nvim"    -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim"  -- Useful lua functions used ny lots of plugins
  use 'kyazdani42/nvim-web-devicons'
  use 'kyazdani42/nvim-tree.lua'
  use { 'akinsho/bufferline.nvim', tag = "*", requires = 'nvim-tree/nvim-web-devicons' }
  use 'nvim-lualine/lualine.nvim'
  use "moll/vim-bbye"

  use 'lewis6991/impatient.nvim'

  use "ssh://git@gitlab.abagile.com:7788/chiao.chuang/vim-abagile.git"

  use({
    'Wansmer/treesj',
    requires = { 'nvim-treesitter/nvim-treesitter' },
  })
  -- search and replace
  use 'windwp/nvim-spectre'

  -- Remove spacing
  use "McAuleyPenney/tidy.nvim"

  -- Navigation
  use 'tpope/vim-projectionist'
  use 'tpope/vim-unimpaired'

  -- Indent
  use 'austintaylor/vim-indentobject'
  use 'lukas-reineke/indent-blankline.nvim'

  -- Commenting
  -- use 'tomtom/tcomment_vim'
  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  }

  -- Treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
  use "nvim-treesitter/playground"

  -- highlight parenthesis
  use "HiPhish/rainbow-delimiters.nvim"
  use {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup {}
    end
  }

  -- CSS #fff
  use {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup()
    end
  }

  -- cmp plugins
  use "hrsh7th/nvim-cmp"         -- The completion plugin
  use "hrsh7th/cmp-buffer"       -- buffer completions
  use "hrsh7th/cmp-path"         -- path completions
  use "hrsh7th/cmp-cmdline"      -- cmdline completions
  use "saadparwaiz1/cmp_luasnip" -- snippet completions
  use "hrsh7th/cmp-nvim-lsp"
  use "PaterJason/cmp-conjure"

  -- snippets
  use "L3MON4D3/LuaSnip" --snippet engine
  use "rafamadriz/friendly-snippets"

  -- LSP
  use "neovim/nvim-lspconfig"   -- enable LSP
  use "williamboman/mason.nvim" -- simple to use language server installer
  use "williamboman/mason-lspconfig.nvim"
  use "nvimtools/none-ls.nvim"  -- ale alternative
  use "folke/trouble.nvim"

  -- Tagbar alternative
  use 'liuchengxu/vista.vim'

  -- Telescope
  use "nvim-telescope/telescope.nvim"
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use { 'nvim-telescope/telescope-ui-select.nvim' }

  -- Git
  use "lewis6991/gitsigns.nvim"
  use 'tpope/vim-fugitive' -- Git commands

  -- Ruby
  use 'tpope/vim-rails' -- only load when opening Ruby file
  use 'tpope/vim-bundler'
  use 'kchmck/vim-coffee-script'
  use 'slim-template/vim-slim'

  use 'tpope/vim-repeat'
  use({
    "kylechui/nvim-surround",
    tag = "*", -- Use for stability; omit to use `main` branch for the latest features
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end
  })
  use "tpope/vim-endwise"
  use 'junegunn/vim-easy-align'
  use 'pedrohdz/vim-yaml-folds'

  use 'christoomey/vim-tmux-navigator'
  use 'christoomey/vim-tmux-runner'
  use 'vim-test/vim-test'

  use { 'Mofiqul/vscode.nvim', branch = 'main' }
  use 'navarasu/onedark.nvim'
  use 'folke/tokyonight.nvim'
  use { 'marko-cerovac/material.nvim', branch = 'main' }
  -- use "projekt0n/github-nvim-theme"
  use { "catppuccin/nvim", as = "catppuccin" }

  -- Clojure, Lisp
  use "gpanders/nvim-parinfer"
  use "guns/vim-sexp"
  use "tpope/vim-sexp-mappings-for-regular-people"
  use 'Olical/conjure'
  use 'clojure-vim/vim-jack-in'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
