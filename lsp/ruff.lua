-- ~/.config/nvim/lsp/ruff.lua
-- Ruff: fast Python linter + formatter as an LSP. Install:
--   pipx install ruff   (or: brew install ruff)
-- Runs alongside pyright; pyright handles types/hover, ruff handles lint+format.
return {
  cmd = { "ruff", "server" },
  filetypes = { "python" },
  root_markers = { "pyproject.toml", "ruff.toml", ".ruff.toml", ".git" },
  init_options = {
    settings = {
      -- Let pyright own hover so we don't see duplicate diagnostics popups.
    },
  },
}
