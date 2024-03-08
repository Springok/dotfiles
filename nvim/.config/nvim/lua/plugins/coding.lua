return {
  -- Navigation
  "tpope/vim-projectionist",
  "tpope/vim-unimpaired",

  { url = "ssh://git@gitlab.abagile.com:7788/chiao.chuang/vim-abagile.git" },

  {
    "Wansmer/treesj",
    config = function()
      require("treesj").setup({
        ---If line after join will be longer than max value,
        ---@type number If line after join will be longer than max value, node will not be formatted
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
  },
  "tpope/vim-endwise",
  "junegunn/vim-easy-align",

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
      { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  },

  -- Git
  "tpope/vim-fugitive",
  "f-person/git-blame.nvim",
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
        numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
        linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
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
        current_line_blame_formatter_opts = {
          relative_time = false,
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
        yadm = {
          enable = false,
        },
      })
    end,
  },

  -- Ruby
  "tpope/vim-rails", -- only load when opening Ruby file
  "tpope/vim-bundler",
  "kchmck/vim-coffee-script",
  "slim-template/vim-slim",

  -- Clojure
  "gpanders/nvim-parinfer",
  "guns/vim-sexp",
  "tpope/vim-sexp-mappings-for-regular-people",
  "Olical/conjure",
  "clojure-vim/vim-jack-in",
}
