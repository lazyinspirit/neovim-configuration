-- ~/.config/nvim/lua/plugins/ai.lua
-- AI integrations.
return {
  -- Claude Code: speaks Claude Code's native WebSocket/MCP protocol
  -- (same protocol the official VS Code / JetBrains extensions use).
  -- Requires the `claude` CLI on $PATH — see README for install steps.
  {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" }, -- optional; falls back to :terminal if absent
    -- Lazy-load on first command or first keymap press.
    cmd = {
      "ClaudeCode", "ClaudeCodeFocus", "ClaudeCodeSend",
      "ClaudeCodeAdd", "ClaudeCodeDiffAccept", "ClaudeCodeDiffDeny",
      "ClaudeCodeSelectModel", "ClaudeCodeTreeAdd",
    },
    opts = {
      -- Use Neovim's built-in :terminal instead of pulling in snacks
      -- as a hard runtime dependency. Snacks is still listed above so
      -- claudecode's diff viewer can use it if present.
      terminal_cmd = nil,                 -- default: "claude"
      terminal = { provider = "native" }, -- "snacks" | "native" | "external"
    },
    -- <leader>c* namespace. NOTE: <leader>ca is already bound to LSP
    -- code-action in lua/lsp_attach.lua and is intentionally skipped here.
    keys = {
      { "<leader>cc", "<cmd>ClaudeCode<cr>",            desc = "Claude: toggle" },
      { "<leader>cf", "<cmd>ClaudeCodeFocus<cr>",       desc = "Claude: focus window" },
      { "<leader>cr", "<cmd>ClaudeCode --resume<cr>",   desc = "Claude: resume session" },
      { "<leader>cC", "<cmd>ClaudeCode --continue<cr>", desc = "Claude: continue last" },
      { "<leader>cm", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Claude: select model" },
      { "<leader>cb", "<cmd>ClaudeCodeAdd %<cr>",       desc = "Claude: add current buffer" },
      { "<leader>cs", "<cmd>ClaudeCodeSend<cr>",        desc = "Claude: send selection", mode = "v" },
      -- nvim-tree integration: from inside the tree buffer this adds the
      -- file under the cursor (or visual range) to Claude's context.
      { "<leader>cs", "<cmd>ClaudeCodeTreeAdd<cr>",     desc = "Claude: add file from tree",
        ft = { "NvimTree" } },
      -- Diff review (used inside Claude's proposed-edit diff buffer).
      { "<leader>cy", "<cmd>ClaudeCodeDiffAccept<cr>",  desc = "Claude: accept diff" },
      { "<leader>cn", "<cmd>ClaudeCodeDiffDeny<cr>",    desc = "Claude: deny diff" },
    },
  },
}
