return {
  -- highlight parenthesis
  "HiPhish/rainbow-delimiters.nvim",
  -- CSS #fff
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end,
  },
}
