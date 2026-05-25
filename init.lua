-- ~/.config/nvim/init.lua

-- Set Leader (must come before lazy.nvim loads, and before any leader mappings)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Editor options
require("options")

-- LSP keymaps (set up via LspAttach autocmd)
require("lsp_attach")

-- <leader>ga: stage all (including new files), commit with a prompted
-- message, then push. Aborts cleanly on empty message. Runs the shell
-- pipeline in one go so a failure at any step skips the rest.
vim.keymap.set("n", "<leader>ga", function()
  vim.ui.input({ prompt = "Commit message: " }, function(msg)
    if not msg or msg == "" then
      vim.notify("git add+commit+push: aborted (empty message)", vim.log.levels.WARN)
      return
    end
    -- shellescape() quotes the message safely for sh, including embedded quotes.
    local cmd = ("git add . && git commit -m %s && git push"):format(vim.fn.shellescape(msg))
    local out = vim.fn.system(cmd)
    if vim.v.shell_error ~= 0 then
      vim.notify("git failed:\n" .. out, vim.log.levels.ERROR)
    else
      vim.notify("Pushed: " .. msg, vim.log.levels.INFO)
    end
  end)
end, { desc = "Git: add . + commit + push" })

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- Install Plugins
require("lazy").setup("plugins")
