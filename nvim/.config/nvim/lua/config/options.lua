-- ============================
--      Settings / options
-- ============================
local options = {
  expandtab = true,  -- expand tabs to spaces
  hidden = true,     -- allow you to switch between buffers without saving
  ignorecase = true, -- case-insensitive search
  cursorline = true,
  hlsearch = false,
  swapfile = false,   -- disable .swp files creation in vim vim.opt.wrap = false
  number = true,      -- show line numbers
  relativenumber = true,
  scrolloff = 8,      -- show context above/below cursorline
  shiftwidth = 2,     -- normal mode indentation commands use 2 spaces
  showcmd = true,
  smartcase = true,   -- case-sensitive search if any caps
  softtabstop = 2,    -- insert mode tab and backspace use 2 spaces
  splitright = true,
  tabstop = 8,        -- actual tabs occupy 8 characters
  undofile = true,
  smartindent = true, -- Insert indents automatically
  wildmode = "longest,list,full",
  termguicolors = true,
  completeopt = { "menuone", "noselect" }, -- mostly just for cmp
  updatetime = 250,
  signcolumn = "yes",
  wildignore = "log/**,node_modules/**,target/**,tmp/**,*.rbc",
  list = true,
  -- foldmethod     = "expr",
  -- foldexpr       = "nvim_treesitter#foldexpr()",
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.opt.nrformats = vim.opt.nrformats + "alpha"
vim.opt.diffopt = vim.opt.diffopt + "vertical"

-- change SpellBad style, have to do this after colorscheme setup, otherwise will be overwritten
vim.cmd([[hi SpellBad ctermbg=20]])
vim.cmd([[hi Winseparator guibg=none]])
