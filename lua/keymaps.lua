-- ~/.config/nvim/lua/keymaps.lua
-- Global keymaps not tied to a specific plugin.

-- Cursor movement remaps
vim.keymap.set('n', '<A-l>', 'w', { desc = 'Next word' })
vim.keymap.set('n', '<A-h>', 'b', { desc = 'Previous word' })
vim.keymap.set('n', '<C-h>', '0', { desc = 'Beginning of line' })
vim.keymap.set('n', '<C-l>', '$', { desc = 'End of line' })

-- Page scrolling remaps
vim.keymap.set('n', '<C-k>', '<C-b>', { desc = 'Page up' })
vim.keymap.set('n', '<C-j>', '<C-f>', { desc = 'Page down' })
vim.keymap.set('n', '<A-k>', '<C-u>', { desc = 'Half page up' })
vim.keymap.set('n', '<A-j>', '<C-d>', { desc = 'Half page down' })

-- <leader>ga: stage all changes (including untracked), commit with a prompted
-- message, then push to the remote. Aborts cleanly at any failure.
vim.keymap.set('n', '<leader>ga', function()
  vim.ui.input({ prompt = 'Commit message: ' }, function(msg)
    if not msg or msg == '' then
      vim.notify('Commit cancelled (empty message)', vim.log.levels.WARN)
      return
    end

    local out = vim.fn.system({ 'git', 'add', '-A' })
    if vim.v.shell_error ~= 0 then
      vim.notify('git add failed:\n' .. out, vim.log.levels.ERROR)
      return
    end

    out = vim.fn.system({ 'git', 'commit', '-m', msg })
    if vim.v.shell_error ~= 0 then
      vim.notify('git commit failed:\n' .. out, vim.log.levels.ERROR)
      return
    end

    out = vim.fn.system({ 'git', 'push' })
    if vim.v.shell_error ~= 0 then
      vim.notify('git push failed:\n' .. out, vim.log.levels.ERROR)
      return
    end

    vim.notify('Pushed: ' .. msg, vim.log.levels.INFO)
  end)
end, { desc = 'Git: stage all, commit, push' })

-- <leader>gl: pull from remote and report result.
vim.keymap.set('n', '<leader>gl', function()
  local out = vim.fn.system({ 'git', 'pull' })
  local level = vim.v.shell_error == 0 and vim.log.levels.INFO or vim.log.levels.ERROR
  vim.notify(out, level)
end, { desc = 'Git: pull' })
