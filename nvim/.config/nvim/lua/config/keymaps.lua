-- ===================
--      keymaps
-- ===================
local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

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
vim.cmd([[
  noremap H ^
  noremap L $
  nnoremap <space><space> <c-^>
]])

-- keymap("n", "H", '^', opts)
-- keymap("n", "L", '$', opts)
keymap("n", "j", "gj", opts)
keymap("n", "k", "gk", opts)
keymap("n", ",gv", "V`", opts)

-- " Keeping it centered
keymap("n", "n", "nzzzv", opts)
keymap("n", "N", "Nzzzv", opts)
keymap("n", "J", "mzJ`z", opts)

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
vim.keymap.set("n", "<leader>ar", ":!tmux display-panes<CR> :VtrAttachToPane<CR>")
vim.keymap.set("n", "<leader>kr", ":VtrKillRunner<CR>")
vim.keymap.set("n", "<leader>ur", ":VtrUnsetRunnerPane<CR>")
vim.keymap.set("n", "<leader>sl", ":VtrSendLinesToRunner<CR>")
vim.keymap.set(
    "n",
    "<leader>rc",
    ":VtrUnsetRunnerPane<CR>:VtrOpenRunner {'orientation': 'v', 'percentage': 15, 'cmd': 'rc'}<CR>"
)

-- start interactive EasyAlign in visual mode
vim.keymap.set("v", "<Enter>", "<Plug>(EasyAlign)")
--  start interactive EasyAlign for a motion/text object (e.g. <leader>eaip)
vim.keymap.set("n", "<leader>l", "<Plug>(EasyAlign)")

vim.keymap.set("n", "<leader>V", ":luafile ~/.config/nvim/init.lua<CR>:echo 'vimrc reloaded!'<CR>")

-- Telescope
keymap("n", "<C-p>", "<cmd>lua require('telescope.builtin').git_files()<cr>", opts)
keymap("n", "<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<cr>", opts)
keymap("n", "<leader>fl", "<cmd>lua require('telescope.builtin').find_files()<cr>", opts)
keymap("n", "<leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<cr>", opts)
keymap("n", "<leader>ff", "<cmd>lua require('telescope.builtin').live_grep()<cr>", opts)
keymap(
    "n",
    "<leader>fo",
    "<cmd>lua require('telescope.builtin').live_grep({prompt_title = 'find string in open buffers...', grep_open_files=true})<cr>",
    opts
)
keymap("n", "<leader>fc", "<cmd>lua require('telescope.builtin').grep_string()<cr>", opts)
keymap("n", "<leader>dl", "<cmd>lua require('telescope.builtin').diagnostics()<cr>", opts)

-- NvimTree
keymap("n", "<leader>dd", ":NvimTreeToggle<cr>", opts)
keymap("n", "<leader>df", ":NvimTreeFindFile<cr>", opts)

-- in case you forgot to sudo
keymap("c", "w!!", "%!sudo tee > /dev/null %", opts)

-- indenting
keymap("n", "<leader>in", "mmgg=G'm", opts)
keymap("n", "<Leader>it", ":IBLToggle<cr>", opts)
keymap("n", "<leader>p", "obinding.pry<ESC>^", term_opts)
keymap("n", "<leader>mr", "oSee merge request metis/nerv!", term_opts)

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
keymap("n", "<Leader>gs", "<cmd>lua require('neogit').open()<CR>", opts)
keymap("n", "<Leader>gB", ":Telescope git_branches<CR>", opts)

-- gitsigns, Navigation
keymap("n", "]c", "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", { expr = true })
keymap("n", "[c", "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", { expr = true })

-- gitsigns, Actions
keymap("n", "<leader>hp", ":Gitsigns preview_hunk<CR>", opts)
keymap("n", "<leader>hr", ":Gitsigns reset_hunk<CR>", opts)
keymap("n", "<leader>hR", ":Gitsigns reset_buffer<CR>", opts)
keymap("v", "<leader>hr", ":Gitsigns reset_hunk<CR>", opts)

keymap("n", "<leader>gdi", ":Gitsigns diffthis<CR>", opts)
keymap("n", "<leader>gdd", ":Gitsigns diffthis ~<CR>", opts)
keymap("n", "<leader>tg", ":Gitsigns toggle_signs<CR>", opts)
keymap("n", "<leader>td", ":Gitsigns toggle_deleted<CR>", opts)

-- gitsigns, Text object
keymap("o", "ih", ":<C-U>Gitsigns select_hunk<CR>", opts)
keymap("x", "ih", ":<C-U>Gitsigns select_hunk<CR>", opts)

-- git-blame
keymap("n", "<leader>tb", ":GitBlameToggle<CR>", opts)

-- Abagile vim
vim.g.abagile_rails_test_runner = 0
keymap("n", "<leader><space>", ":call abagile#whitespace#strip_trailing()<cr>", opts)

-- Vim Test
vim.g["test#strategy"] = "vtr"

keymap("n", "<leader>tn", ":TestNearest<CR>", opts)
keymap("n", "<leader>tc", ":TestNearest<CR>", opts)
keymap("n", "<leader>tf", ":TestFile<CR>", opts)
keymap("n", "<leader>tl", ":TestLast<CR>", opts)
keymap("n", "<leader>ta", ":TestSuite<cr>", opts)
keymap("n", "<leader>tg", ":TestVisit<cr>", opts)

keymap("n", "<Leader>]", ":Vista<cr>", opts)

-- Spectre, search and replace
keymap("v", "<leader>fc", "<cmd>lua require('spectre').open_visual()<CR>", opts)
