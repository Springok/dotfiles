return {
  "nvim-lualine/lualine.nvim",
  version = "*",
  config = function()
    require('lualine').setup {
      tabline = {},
      extensions = {},
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {}
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'diff', 'diagnostics' },
        lualine_c = { 'filename' },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
      },
      options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {},
        always_divide_middle = true,
        globalstatus = false,
        mode = "buffers",
        numbers = "none", -- | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
        close_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
        right_mouse_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
        left_mouse_command = "buffer %d", -- can be a string | function, see "Mouse actions"
        middle_mouse_command = nil, -- can be a string | function, see "Mouse actions"
        -- NOTE: this plugin is designed with this icon in mind,
        -- and so changing this is NOT recommended, this is intended
        -- as an escape hatch for people who cannot bear it for whatever reason
        indicator = {
          style = 'icon',
          icon = "▎",
        },
        buffer_close_icon = "",
        -- buffer_close_icon = '',
        modified_icon = "●",
        close_icon = "",
        -- close_icon = '',
        left_trunc_marker = "",
        right_trunc_marker = "",
        --- name_formatter can be used to change the buffer's label in the bufferline.
        --- Please note some names can/will break the
        --- bufferline so use this at your discretion knowing that it has
        --- some limitations that will *NOT* be fixed.
        -- name_formatter = function(buf)  -- buf contains a "name", "path" and "bufnr"
        --   -- remove extension from markdown files for example
        --   if buf.name:match('%.md') then
        --     return vim.fn.fnamemodify(buf.name, ':t:r')
        --   end
        -- end,
        max_name_length = 18,
        max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
        tab_size = 18,
        diagnostics = false, -- | "nvim_lsp" | "coc",
        diagnostics_update_in_insert = false,
        -- diagnostics_indicator = function(count, level, diagnostics_dict, context)
        --   return "("..count..")"
        -- end,
        -- NOTE: this will be called a lot so don't do any heavy processing here
        -- custom_filter = function(buf_number)
        --   -- filter out filetypes you don't want to see
        --   if vim.bo[buf_number].filetype ~= "<i-dont-want-to-see-this>" then
        --     return true
        --   end
        --   -- filter out by buffer name
        --   if vim.fn.bufname(buf_number) ~= "<buffer-name-I-dont-want>" then
        --     return true
        --   end
        --   -- filter out based on arbitrary rules
        --   -- e.g. filter out vim wiki buffer from tabline in your work repo
        --   if vim.fn.getcwd() == "<work-repo>" and vim.bo[buf_number].filetype ~= "wiki" then
        --     return true
        --   end
        -- end,
        offsets = { { filetype = "NvimTree", text = "EXPLORER", text_align = "center" } },
        show_buffer_icons = true,
        show_buffer_close_icons = false,
        show_close_icon = false,
        show_tab_indicators = true,
        persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
        -- can also be a table containing 2 custom separators
        -- [focused and unfocused]. eg: { '|', '|' }
        separator_style = "thin", -- | "thick" | "thin" | { 'any', 'any' },
        enforce_regular_tabs = true,
        always_show_bufferline = true,
        sort_by = 'id',
        -- sort_by = 'insert_after_current' |'insert_at_end' | 'id' | 'extension' | 'relative_directory' | 'directory' | 'tabs' | function(buffer_a, buffer_b)
        --   -- add custom logic
        --   return buffer_a.modified > buffer_b.modified
        -- end
      },
      -- tokyonight
      -- highlights = {
      --   fill = {
      --     guifg = { attribute = "fg", highlight = "#ff0000" },
      --     guibg = { attribute = "bg", highlight = "TabLine" },
      --   },
      --   background = {
      --     guifg = { attribute = "fg", highlight = "TabLine" },
      --     guibg = { attribute = "bg", highlight = "TabLine" },
      --   },
      --   -- buffer_selected = {
      --   --   guifg = {attribute='fg',highlight='Normal'},
      --   --   guibg = {attribute='bg',highlight='Normal'},
      --   -- },
      --   buffer_visible = {
      --     guifg = { attribute = "fg", highlight = "TabLine" },
      --     guibg = { attribute = "bg", highlight = "TabLine" },
      --   },
      --   modified = {
      --     guifg = { attribute = "fg", highlight = "TabLine" },
      --     guibg = { attribute = "bg", highlight = "TabLine" },
      --   },
      --   modified_selected = {
      --     guifg = { attribute = "fg", highlight = "Normal" },
      --     guibg = { attribute = "bg", highlight = "Normal" },
      --   },
      --   modified_visible = {
      --     guifg = { attribute = "fg", highlight = "TabLine" },
      --     guibg = { attribute = "bg", highlight = "TabLine" },
      --   },
      --
      --   separator = {
      --     guifg = { attribute = "bg", highlight = "TabLine" },
      --     guibg = { attribute = "bg", highlight = "TabLine" },
      --   },
      --   separator_selected = {
      --     guifg = { attribute = "bg", highlight = "Normal" },
      --     guibg = { attribute = "bg", highlight = "Normal" },
      --   },
      --   -- separator_visible = {
      --   --   guifg = {attribute='bg',highlight='TabLine'},
      --   --   guibg = {attribute='bg',highlight='TabLine'}
      --   --   },
      --   indicator_selected = {
      --     guifg = { attribute = "fg", highlight = "LspDiagnosticsDefaultHint" },
      --     guibg = { attribute = "bg", highlight = "Normal" },
      --   },
      -- },
    }
  end,
}