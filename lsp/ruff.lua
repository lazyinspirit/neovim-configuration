-- ~/.config/nvim/lsp/ruff.lua
-- Ruff: fast Python linter + formatter as an LSP. Install:
--   brew install ruff   (or: pipx install ruff)
-- Runs alongside pyright; pyright handles types/hover, ruff handles lint+format.
-- Disable ruff's hover provider to avoid duplicate popups with pyright.
return {
  cmd = { "ruff", "server" },
  filetypes = { "python" },
  root_markers = { "pyproject.toml", "ruff.toml", ".ruff.toml", ".git" },
  on_attach = function(client, _)
    client.server_capabilities.hoverProvider = false
  end,
}
