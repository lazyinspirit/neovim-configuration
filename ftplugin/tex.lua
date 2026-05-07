-- ~/.config/nvim/ftplugin/tex.lua

-- Enable texlab LSP
vim.lsp.enable('texlab')

-- Write Neovim server address to known location for Skim inverse search [23]
vim.fn.writefile({ vim.v.servername }, "/tmp/vimtexserver.txt")

-- Keymaps
local opts = { buffer = true, silent = true }

vim.keymap.set("n", "<localleader>x", "<cmd>VimtexCompile<CR>", opts)
vim.keymap.set("n", "<localleader>lv", "<cmd>VimtexView<CR>", opts)
vim.keymap.set("n", "<localleader>lk", "<cmd>VimtexStop<CR>", opts)
vim.keymap.set("n", "<localleader>le", "<cmd>VimtexErrors<CR>", opts)
vim.keymap.set("n", "<localleader>lc", "<cmd>VimtexClean<CR>", opts)
vim.keymap.set("n", "<localleader>lt", "<cmd>VimtexTocToggle<CR>", opts)

vim.keymap.set("n", "<2-LeftMouse>", "<cmd>VimtexView<CR>", opts)
vim.keymap.set("n", "<localleader>ls", function()
  vim.lsp.buf.execute_command({
    command = "texlab.forwardSearch",
    arguments = { vim.uri_from_bufnr(0), vim.api.nvim_win_get_cursor(0)[1] },
  })
end, opts)
