-- vscode-json-language-server: schema validation and error checking for JSON/JSONC.
-- Installed via: npm i -g vscode-langservers-extracted
return {
  cmd = { "vscode-json-language-server", "--stdio" },
  filetypes = { "json", "jsonc" },
  root_markers = { ".git" },
  init_options = { provideFormatter = true },
}
