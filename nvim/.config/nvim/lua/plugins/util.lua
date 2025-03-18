return {
  "nvim-lua/plenary.nvim", -- Useful lua functions used ny lots of plugins
  "lewis6991/impatient.nvim",

  -- Remove spacing
  "McAuleyPenney/tidy.nvim",
  {
    "mistricky/codesnap.nvim",
    config = function()
      require("codesnap").setup({
        bg_theme = "bamboo",
        bg_padding = 0,
        watermark = nil,
        mac_window_bar = false,
        save_path = "~/proj/tmp/codesnap/"
        -- has_breadcrumbs = true,
        -- show_workspace = true,
        -- has_line_number = true,
      })
    end,
    build = "make"
  },
}
