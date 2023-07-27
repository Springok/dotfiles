-- Lua modules are found inside a lua/ folder in your 'runtimepath' (for most users, this will mean ~/.config/nvim/lua
local ok, impatient = pcall(require, 'impatient')
if ok then
  impatient.enable_profile()
else
  vim.notify(impatient)
end

require "config.plugins"
require "config.cmp"
require "config.lsp"
require "config.telescope"
require "config.treesitter"
require "config.gitsigns"
require "config.nvim-tree"
require "config.bufferline"

-- ================
--      Theme
-- ================
-- vim.g.onedark_config = { style = "warmer" }
-- vim.cmd [[colorscheme onedark]]
-- vim.g.vscode_style = "dark"
-- vim.cmd [[colorscheme vscode]]
-- vim.cmd [[colorscheme tokyonight]]
-- vim.g.material_style = "darker"
-- vim.cmd [[colorscheme material]]
vim.cmd [[colorscheme catppuccin]]

-- =================
--      Plugins
-- =================

-- null ls
local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local formatting  = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

-- bundle, https://github.com/jose-elias-alvarez/null-ls.nvim/issues/270
null_ls.setup({
  sources = {
    diagnostics.rubocop.with({
      command = "bundle",
      args = vim.list_extend({ "exec", "rubocop" }, diagnostics.rubocop._opts.args)
    }),
    formatting.rubocop.with({
      command = "bundle",
      args = vim.list_extend({ "exec", "rubocop" }, formatting.rubocop._opts.args)
    }),
    diagnostics.trail_space,
    -- clojure lsp supported by default
    -- diagnostics.clj_kondo,
    -- formatting.cljstyle,
  },
})

-- Vista, not working, not sure why...
vim.g.vista_executive_for = {
  clj = "nvim_lsp",
  cljs = "nvim_lsp"
}

-- rainbow_delimiters, This module contains a number of default definitions
local rainbow_delimiters = require 'rainbow-delimiters'

vim.g.rainbow_delimiters = {
  strategy = {
    [''] = rainbow_delimiters.strategy['global'],
    vim = rainbow_delimiters.strategy['local'],
  },
  query = {
    [''] = 'rainbow-delimiters',
    lua = 'rainbow-blocks',
  },
  highlight = {
    'RainbowDelimiterRed',
    'RainbowDelimiterYellow',
    'RainbowDelimiterBlue',
    'RainbowDelimiterOrange',
    'RainbowDelimiterGreen',
    'RainbowDelimiterViolet',
    'RainbowDelimiterCyan',
  },
}

-- ============================
--      Settings / options
-- ============================
local options = {
  expandtab      = true, -- expand tabs to spaces
  hidden         = true, -- allow you to switch between buffers without saving
  ignorecase     = true, -- case-insensitive search
  cursorline     = false,
  hlsearch       = false,
  swapfile       = false, -- disable .swp files creation in vim vim.opt.wrap = false
  number         = true, -- show line numbers
  relativenumber = true,
  scrolloff      = 8, -- show context above/below cursorline
  shiftwidth     = 2, -- normal mode indentation commands use 2 spaces
  showcmd        = true,
  smartcase      = true, -- case-sensitive search if any caps
  softtabstop    = 2, -- insert mode tab and backspace use 2 spaces
  splitright     = true,
  tabstop        = 8, -- actual tabs occupy 8 characters
  undofile       = true,
  smartindent    = true, -- Insert indents automatically
  wildmode       = 'longest,list,full',
  termguicolors  = true,
  completeopt    = { "menuone", "noselect" }, -- mostly just for cmp
  updatetime     = 250,
  signcolumn     = "yes",
  wildignore     = 'log/**,node_modules/**,target/**,tmp/**,*.rbc',
  list           = true,
  -- foldmethod     = "expr",
  -- foldexpr       = "nvim_treesitter#foldexpr()",
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.opt.nrformats = vim.opt.nrformats + "alpha"
vim.opt.diffopt   = vim.opt.diffopt + "vertical"

-- change SpellBad style, have to do this after colorscheme setup, otherwise will be overwritten
vim.cmd [[hi SpellBad ctermbg=20]]
vim.cmd [[hi Winseparator guibg=none]]

-- vim-easy-align
-- default ignore comment and string
vim.g.easy_align_ignore_groups = {}
-- vim.g.abagile_migrant_structure_fold = 1

-- indent_blankline
vim.g.indent_blankline_enabled = "v:false"
require("indent_blankline").setup {
  show_current_context = true,
  show_current_context_start = true,
}

-- sexp
vim.g.sexp_enable_insert_mode_mappings = 0

-- Conjure
vim.g['conjure#log#hud#width'] = 0.7
vim.g['conjure#log#hud#height'] = 0.7
vim.g['conjure#log#hud#anchor'] = "SE"
vim.g['conjure#highlight#enable'] = 'true'
vim.g['conjure#log#botright'] = 'true'

-- ==================
--      Autocmd
-- ==================
vim.cmd [[
  augroup _general_settings
    autocmd!
    autocmd FileType qf,help,man,lspinfo nnoremap <silent> <buffer> q :close<CR>
    autocmd TextYankPost * silent!lua require('vim.highlight').on_yank({higroup = 'Visual', timeout = 200})
    autocmd BufWinEnter * :set formatoptions-=cro
    autocmd FileType qf set nobuflisted
    autocmd BufNewFile,BufRead *.slim setlocal filetype=slim
    autocmd BufNewFile,BufRead *.thor,.pryrc,pryrc setlocal filetype=ruby
    autocmd BufNewFile,BufRead ssh_config,*/.ssh/config.d/*  setf sshconfig
    " https://github.com/neovim/neovim/issues/7994#issuecomment-388296360
    autocmd InsertLeave * set nopaste
    autocmd User Rails silent! Rnavcommand job app/jobs -glob=**/* -suffix=_job.rb
    autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false, scope="cursor"})
  augroup end
  augroup _git
    autocmd!
    autocmd FileType gitcommit setlocal wrap
    autocmd FileType gitcommit setlocal spell textwidth=72
    autocmd Filetype gitcommit nmap <buffer> <leader>p oSee merge request metis/nerv!
  augroup end
  augroup _yml
    autocmd!
    autocmd BufRead,BufNewFile *.fdoc set filetype=yaml
    autocmd BufRead,BufNewFile *.yml setlocal spell
  augroup end
  augroup _auto_resize
    " automatically rebalance windows on vim resize
    autocmd!
    autocmd VimResized * tabdo wincmd =
  augroup end
  augroup _clojure
    autocmd!
  " autocmd FileType clojure setlocal iskeyword+=?,*,!,+,/,=,<,>,$
    autocmd FileType clojure setlocal iskeyword-=.
    autocmd FileType clojure setlocal iskeyword-=/
    autocmd FileType clojure nmap <buffer> <leader>p i(debux.core/dbg<Space>
  augroup end
]]

-- ===================
--      keymaps
-- ===================
local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

-- Remap leader key
vim.g.mapleader = ','
-- vim.g.maplocalleader = " "

--  discard direction keys
keymap("n", "<up>", "<nop>", opts)
keymap("n", "<down>", "<nop>", opts)
keymap("n", "<left>", "<nop>", opts)
keymap("n", "<right>", "<nop>", opts)

keymap("i", "<up>", "<nop>", opts)
keymap("i", "<down>", "<nop>", opts)
keymap("i", "<left>", "<nop>", opts)
keymap("i", "<right>", "<nop>", opts)

-- sometimes need, to repeat latest f, t, F or T in opposite direction
keymap("", "\\", ",", opts)

-- " Helps when I want to delete something without clobbering my unnamed register.
keymap("n", "s", '"_d', opts)
keymap("n", "ss", '"_dd', opts)

-- " navigating
vim.cmd [[
  noremap H ^
  noremap L $
]]

-- keymap("n", "H", '^', opts)
-- keymap("n", "L", '$', opts)
keymap("n", "j", 'gj', term_opts)
keymap("n", "k", 'gk', term_opts)
keymap("n", ",gv", 'V`', opts)

-- " Keeping it centered
keymap("n", "n", 'nzzzv', opts)
keymap("n", "N", 'Nzzzv', opts)
keymap("n", "J", 'mzJ`z', opts)

keymap("n", "<C-n>", "<C-i>", opts)

keymap("n", "Y", "yg_", opts)

-- " moving text
keymap("v", "J", ":m '>+1<CR>gv=gv", opts)
keymap("v", "K", ":m '<-2<CR>gv=gv", opts)
-- " Don't copy the contents of an overwritten selection.
keymap("v", "p", '"_dP', opts)

--  Vim Tmux Navigator
-- vim.g['tmux_navigator_disable_when_zoomed'] = 1

-- " Vim Tmux Runner
vim.keymap.set('n', '<leader>ar', ":VtrAttachToPane<CR>")
vim.keymap.set('n', '<leader>kr', ":VtrKillRunner<CR>")
vim.keymap.set('n', '<leader>ur', ":VtrUnsetRunnerPane<CR>")
vim.keymap.set('n', '<leader>sl', ":VtrSendLinesToRunner<CR>")
vim.keymap.set('n', '<leader>rc', ":VtrOpenRunner {'orientation': 'v', 'percentage': 15, 'cmd': 'rc'}<CR>")

-- start interactive EasyAlign in visual mode
vim.keymap.set('v', "<Enter>", "<Plug>(EasyAlign)")
--  start interactive EasyAlign for a motion/text object (e.g. <leader>eaip)
vim.keymap.set('n', "<leader>l", "<Plug>(EasyAlign)")

vim.keymap.set('n', "<leader>V", ":luafile ~/.config/nvim/init.lua<CR>:echo 'vimrc reloaded!'<CR>")

-- Telescope
keymap("n", "<C-p>", "<cmd>lua require('telescope.builtin').git_files()<cr>", opts)
keymap("n", "<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<cr>", opts)
keymap("n", "<leader>fl", "<cmd>lua require('telescope.builtin').find_files()<cr>", opts)
keymap("n", "<leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<cr>", opts)
keymap("n", "<leader>ff", "<cmd>lua require('telescope.builtin').live_grep()<cr>", opts)
keymap("n", "<leader>fo", "<cmd>lua require('telescope.builtin').live_grep({grep_open_files=true})<cr>", opts)
keymap("n", "<leader>fc", "<cmd>lua require('telescope.builtin').grep_string()<cr>", opts)
keymap("n", "<leader>dl", "<cmd>lua require('telescope.builtin').diagnostics()<cr>", opts)

-- NvimTree
keymap("n", "<leader>dd", ":NvimTreeToggle<cr>", opts)
keymap("n", "<leader>df", ":NvimTreeFindFile<cr>", opts)

-- in case you forgot to sudo
keymap("c", "w!!", "%!sudo tee > /dev/null %", opts)

-- indenting
keymap("n", "<leader>in", "mmgg=G'm", opts)
keymap("n", "<Leader>it", ":IndentBlanklineToggle<cr>", opts)
keymap("n", "<leader>p", "obinding.pry<ESC>^", term_opts)

-- use system clipboard
keymap("v", "<Leader>y", '"+y', opts)
keymap("n", "<Leader>P", '"+p', opts)
keymap("n", "<Leader>y", '"+y', opts)
keymap("n", "<Leader>fy", ":let @+ = expand('%')<cr>:echo 'filename copied!'<cr>", opts)

-- window
keymap("n", "<leader>w", "<C-w>", opts)
keymap("n", "<leader>wf", "<C-w>f<C-w>H", opts)

-- buffer switch
keymap("n", "<tab>", ":bn<CR>", opts)
keymap("n", "<S-tab>", ":bp<CR>", opts)

-- Note that remapping C-s requires flow control to be disabled (in .zshrc)
keymap("n", "<C-s>", "<esc>:w<CR>", opts)
keymap("i", "<C-s>", "<esc>:w<CR>", opts)
keymap("v", "<C-s>", "<esc>:w<CR>", opts)

-- Close current buffer
keymap("n", "<leader>q", "<esc>:bw<cr>", opts)
keymap("n", "<leader>x", "<esc>:bw<cr>", opts)
keymap("i", "<leader>q", "<esc>:bw<cr>", opts)
keymap("i", "<leader>x", "<esc>:bw<cr>", opts)

--  in all modes hit ,, can return to normal mode
keymap("n", ",,", "<C-\\><C-N>", opts)
keymap("i", ",,", "<C-\\><C-N>", opts)

-- run commands in vim
keymap("n", "<leader>ss", ":!rpu<enter>", opts)
keymap("n", "<leader>ks", ":!krpu<enter>", opts)

-- Rails
keymap("n", "<leader>aa", ":A<CR>", opts)
keymap("n", "<leader>av", ":AV<CR>", opts)
keymap("n", "<leader>gr", ":R<CR>", opts)
keymap("n", "<leader>vl", ":sp<cr><C-^><cr>", opts)
keymap("n", "<leader>hl", ":vsp<cr><C-^><cr>", opts)

-- Git related plugins,
-- fugitive
keymap("n", "<leader>gb", ":Git blame<cr>", opts)

-- gitsigns, Navigation
keymap('n', ']c', "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", { expr = true })
keymap('n', '[c', "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", { expr = true })

-- gitsigns, Actions
keymap('n', '<leader>hp', ':Gitsigns preview_hunk<CR>', opts)
keymap('n', '<leader>hr', ':Gitsigns reset_hunk<CR>', opts)
keymap('v', '<leader>hr', ':Gitsigns reset_hunk<CR>', opts)

keymap('n', '<leader>gdi', ':Gitsigns diffthis<CR>', opts)
keymap('n', '<leader>gdd', ':Gitsigns diffthis ~<CR>', opts)
keymap('n', '<leader>tg', ':Gitsigns toggle_signs<CR>', opts)
keymap('n', '<leader>tb', ':Gitsigns toggle_current_line_blame<CR>', opts)
keymap('n', '<leader>td', ':Gitsigns toggle_deleted<CR>', opts)

-- gitsigns, Text object
keymap('o', 'ih', ':<C-U>Gitsigns select_hunk<CR>', opts)
keymap('x', 'ih', ':<C-U>Gitsigns select_hunk<CR>', opts)

-- Abagile vim
vim.g.abagile_rails_test_runner = 0
keymap("n", "<leader><space>", ":call abagile#whitespace#strip_trailing()<cr>", opts)

-- Vim Test
vim.g["test#strategy"] = "vtr"

keymap("n", "<leader>tn", ":TestNearest<CR>", opts)
keymap("n", "<leader>tf", ":TestFile<CR>", opts)
keymap("n", "<leader>tl", ":TestLast<CR>", opts)
keymap("n", "<leader>ta", ":TestSuite<cr>", opts)
keymap("n", "<leader>tg", ":TestVisit<cr>", opts)


keymap("n", "<Leader>]", ":Vista<cr>", opts)

-- Spectre, search and replace
keymap("v", "<leader>fc", "<cmd>lua require('spectre').open_visual()<CR>", opts)
