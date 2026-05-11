-- ~/.config/nvim/lsp/ts_ls.lua
-- TypeScript/JavaScript LSP. Requires `typescript-language-server`:
--   npm i -g typescript typescript-language-server
return {
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },
  init_options = { hostInfo = "neovim" },
}
