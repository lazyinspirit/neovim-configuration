-- ~/.config/nvim/init.lua

-- Set Leader (must come before lazy.nvim loads, and before any leader mappings)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Editor options
require("options")

-- LSP keymaps (set up via LspAttach autocmd)
require("lsp_attach")

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- Install Plugins
require("lazy").setup("plugins")
