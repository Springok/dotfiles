return {
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  { "nvim-telescope/telescope-ui-select.nvim" },
  {
    "nvim-telescope/telescope.nvim",
    tag = '0.1.8',
    config = function()
      local actions = require("telescope.actions")
      local tele = require("telescope")
      tele.setup {
        defaults = {
          file_ignore_patterns = { "vendor/", "migrate_archive", "snippets", "image", ".lsp/", ".clj-kondo/" },
          prompt_prefix = " ",
          selection_caret = " ",
          path_display = { "truncate" },
          vimgrep_arguments = { "rg", "--column", "--line-number", "--no-heading", "--color=never", "--ignore" },

          -- layout setup copied from TJ DeVries
          layout_config = {
            width = 0.95,
            height = 0.85,
            prompt_position = "top",

            horizontal = {
              preview_width = function(_, cols, _)
                if cols > 200 then
                  return math.floor(cols * 0.4)
                else
                  return math.floor(cols * 0.6)
                end
              end,
            },

            vertical = {
              width = 0.9,
              height = 0.95,
              preview_height = 0.5,
            },

            flex = {
              horizontal = {
                preview_width = 0.9,
              },
            },
          },

          mappings = {
            i = {
              ["<C-j>"] = actions.cycle_history_next,
              ["<C-k>"] = actions.cycle_history_prev,

              ["<C-n>"] = actions.move_selection_next,
              ["<C-p>"] = actions.move_selection_previous,

              ["<C-c>"] = actions.close,

              ["<Down>"] = actions.cycle_history_next,
              ["<Up>"] = actions.cycle_history_prev,

              ["<CR>"] = actions.select_default,
              ["<C-x>"] = actions.select_horizontal,
              ["<C-v>"] = actions.select_vertical,
              -- ["<C-t>"] = actions.select_tab,

              ["<C-u>"] = actions.preview_scrolling_up,
              ["<C-d>"] = actions.preview_scrolling_down,

              ["<PageUp>"] = actions.results_scrolling_up,
              ["<PageDown>"] = actions.results_scrolling_down,

              ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
              ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
              ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
              ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
              ["<C-l>"] = actions.complete_tag,
              ["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
            },

            n = {
              ["<C-c>"] = actions.close,
              ["<CR>"] = actions.select_default,
              ["<C-x>"] = actions.select_horizontal,
              ["<C-v>"] = actions.select_vertical,
              ["<C-t>"] = actions.select_tab,

              ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
              ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
              ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
              ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

              ["j"] = actions.move_selection_next,
              ["k"] = actions.move_selection_previous,
              ["H"] = actions.move_to_top,
              ["M"] = actions.move_to_middle,
              ["L"] = actions.move_to_bottom,

              ["<Down>"] = actions.move_selection_next,
              ["<Up>"] = actions.move_selection_previous,
              ["gg"] = actions.move_to_top,
              ["G"] = actions.move_to_bottom,

              ["<C-u>"] = actions.preview_scrolling_up,
              ["<C-d>"] = actions.preview_scrolling_down,

              ["<PageUp>"] = actions.results_scrolling_up,
              ["<PageDown>"] = actions.results_scrolling_down,

              ["?"] = actions.which_key,
            },
          },
        },
        pickers = {
          buffers = {
            theme = "ivy",
            previewer = false,
          },
          git_files = {
            theme = "ivy",
            previewer = true,
          },
          lsp_references = {
            theme = "dropdown"
          },
          -- Default configuration for builtin pickers goes here:
          -- picker_name = {
          --   picker_config_key = value,
          --   ...
          -- }
          -- Now the picker_config_key will be applied every time you call this
          -- builtin picker
        },
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown {
            },
          },
          fzf = {
            fuzzy = true,                 -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true,  -- override the file sorter
            case_mode = "smart_case",     -- or "ignore_case" or "respect_case"
          },
        }
      }
      tele.load_extension("ui-select")
      tele.load_extension('fzf')
    end,
  }
}
