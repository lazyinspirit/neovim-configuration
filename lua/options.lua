-- ~/.config/nvim/lua/options.lua
-- Sensible editor defaults. Loaded from init.lua before plugins.

local opt = vim.opt

-- UI
opt.number = true             -- show absolute line number on current line
opt.relativenumber = true     -- and relative numbers on others (jump with [N]j/k)
opt.signcolumn = "yes"        -- always reserve sign column to avoid text shift
opt.cursorline = true         -- highlight current line
opt.termguicolors = true      -- 24-bit colors (needed for onedark)
opt.scrolloff = 8             -- keep 8 lines of context around cursor
opt.sidescrolloff = 8
opt.wrap = true               -- soft-wrap long lines at the window edge
opt.linebreak = true          -- break at word boundaries, not mid-word
opt.breakindent = true        -- wrapped lines continue at the same indent level
opt.showmode = false          -- lualine already shows mode

-- Indentation: 2-space default, ftplugin overrides for languages that want 4
opt.expandtab = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.smartindent = true

-- Search
opt.ignorecase = true
opt.smartcase = true          -- case-sensitive if pattern has uppercase
opt.hlsearch = true
opt.incsearch = true

-- Splits open in the natural direction
opt.splitright = true
opt.splitbelow = true

-- Persistence: undo history survives across restarts
opt.undofile = true

-- Use the macOS pasteboard for yank/paste
opt.clipboard = "unnamedplus"

-- Mouse support in all modes (handy for Skim inverse search clicks)
opt.mouse = "a"

-- Faster CursorHold / nvim-tree responsiveness
opt.updatetime = 250

-- Don't pass messages to ins-completion-menu
opt.shortmess:append("c")
