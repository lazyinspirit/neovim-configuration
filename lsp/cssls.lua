-- ~/.config/nvim/lsp/cssls.lua
-- CSS / SCSS / Less language server. Requires `vscode-css-language-server`:
--   npm i -g vscode-langservers-extracted
return {
  cmd = { "vscode-css-language-server", "--stdio" },
  filetypes = { "css", "scss", "less" },
  root_markers = { "package.json", ".git" },
  settings = {
    css = { validate = true },
    scss = { validate = true },
    less = { validate = true },
  },
}
