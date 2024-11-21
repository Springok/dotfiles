return {
  -- Navigation
  "tpope/vim-unimpaired",

  { url = "ssh://git@gitlab.abagile.com:7788/abagile/vim-abagile.git" },

  {
    "Wansmer/treesj",
    config = function()
      require("treesj").setup({
        max_join_length = 500
      })
    end,
  },

  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
    -- use opts = {} for passing setup options
    -- this is equalent to setup({}) function
  },

  "tpope/vim-repeat",
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end
  },
  "tpope/vim-endwise",
  {
    "junegunn/vim-easy-align",
    config = function()
      -- default ignore comment and string
      vim.g.easy_align_ignore_groups = {}
    end
  },

  "austintaylor/vim-indentobject",

  -- Commenting
  -- 'tomtom/tcomment_vim'
  {
    "numToStr/Comment.nvim",
    opts = {
      -- add any options here
    },
    lazy = false,
  },

  -- search and replace
  "nvim-pack/nvim-spectre",

  "vim-test/vim-test",

  "christoomey/vim-tmux-runner",
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    keys = {
      { "<c-h>",  "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>",  "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>",  "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>",  "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  },

  -- Git
  "tpope/vim-fugitive",
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",  -- required
      "sindrets/diffview.nvim", -- optional - Diff integration
    },
    config = function()
      require("neogit").setup({
        kind = "vsplit",
      })
    end,
  },
  -- "f-person/git-blame.nvim",
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { text = "│" },
          change = { text = "│" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
          untracked = { text = "┆" },
        },
        signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
        numhl = false,     -- Toggle with `:Gitsigns toggle_numhl`
        linehl = false,    -- Toggle with `:Gitsigns toggle_linehl`
        word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
        watch_gitdir = {
          interval = 1000,
          follow_files = true,
        },
        attach_to_untracked = true,
        current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
          delay = 1000,
          ignore_whitespace = false,
        },
        sign_priority = 6,
        update_debounce = 100,
        status_formatter = nil, -- Use default
        max_file_length = 40000,
        preview_config = {
          -- Options passed to nvim_open_win
          border = "single",
          style = "minimal",
          relative = "cursor",
          row = 0,
          col = 1,
        },
      })
    end,
  },
  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
      { "<leader>lg", "<cmd>LazyGit<cr>", desc = "Open lazy git" },
    },
  },

  -- Ruby
  "tpope/vim-rails", -- only load when opening Ruby file
  "tpope/vim-bundler",
  "kchmck/vim-coffee-script",
  "slim-template/vim-slim",

  -- Clojure
  "gpanders/nvim-parinfer",
  "tpope/vim-sexp-mappings-for-regular-people",
  "clojure-vim/vim-jack-in",

  {
    "Olical/conjure",
    config = function()
      vim.g["conjure#log#hud#width"] = 0.7
      vim.g["conjure#log#hud#height"] = 0.7
      vim.g["conjure#log#hud#anchor"] = "SE"
      vim.g["conjure#highlight#enable"] = "true"
      vim.g["conjure#log#botright"] = "true"
    end
  },
  {
    "guns/vim-sexp",
    config = function()
      vim.g.sexp_enable_insert_mode_mappings = 0
    end
  },
}
