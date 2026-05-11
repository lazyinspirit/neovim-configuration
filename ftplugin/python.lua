-- ~/.config/nvim/ftplugin/python.lua
-- Pyright owns types/hover; ruff owns lint + format.
vim.lsp.enable("pyright")
vim.lsp.enable("ruff")
