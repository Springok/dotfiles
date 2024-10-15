return {
  {
    "shaunsingh/nord.nvim",
    config = function()
      vim.cmd [[colorscheme nord]]
    end
  },
  {
    "Mofiqul/vscode.nvim",
    branch = "main",
    config = function()
      -- vim.g.vscode_style = "dark"
      -- vim.cmd [[colorscheme vscode]]
    end
  },
  {
    "navarasu/onedark.nvim",
    config = function()
      -- vim.g.onedark_config = { style = "warmer" }
      -- vim.cmd [[colorscheme onedark]]
    end
  },
  {
    "folke/tokyonight.nvim",
    config = function()
      -- require("tokyonight").setup({
      -- style = "night",
      -- })
      -- vim.cmd [[colorscheme tokyonight]]
    end
  },
  {
    "marko-cerovac/material.nvim",
    branch = "main",
    config = function()
      -- vim.g.material_style = "darker"
      -- vim.cmd [[colorscheme material]]
    end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    config = function()
      -- vim.cmd([[colorscheme catppuccin]])
    end,
  },
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = function ()
      -- vim.o.background = "dark" -- or "light" for light mode
      -- vim.cmd([[colorscheme gruvbox]])
    end
  }
}
