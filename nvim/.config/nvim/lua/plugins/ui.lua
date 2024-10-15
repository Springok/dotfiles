return {
  "nvim-lua/popup.nvim", -- An implementation of the Popup API from vim in Neovim
  {
    "HiPhish/rainbow-delimiters.nvim",
    config = function()
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
        }
      }
    end,
  },

  -- CSS #fff
  {
    "NvChad/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({
        user_default_options = { tailwind = true }
      })
    end,
  },

  -- Indent
  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      -- local highlight = {
      --   "CursorColumn",
      --   "Whitespace",
      -- }
      require("ibl").setup({
        -- indent = { highlight = highlight, char = "" },
        whitespace = {
          -- highlight = highlight,
          remove_blankline_trail = true,
        },
        indent = {
          char = "│",
          tab_char = "│",
        },
        scope = { enabled = false },
        exclude = {
          filetypes = {
            "help",
            "alpha",
            "dashboard",
            "neo-tree",
            "Trouble",
            "trouble",
            "lazy",
            "mason",
            "notify",
            "toggleterm",
            "lazyterm",
          },
        },
      })
    end
  },

  -- Tagbar alternative
  -- Vista, not working, not sure why...
  {
    "liuchengxu/vista.vim",
    config = function()
      vim.g.vista_executive_for = {
        clj = "nvim_lsp",
        cljs = "nvim_lsp",
      }
    end
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  }
}
