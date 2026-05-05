-- ~/.config/nvim/lsp/clangd.lua
return {
  name = "clangd",
  cmd = { "clangd" },
  filetypes = { "c", "cpp", "objc", "objcpp" },
  root_markers = { ".git", "compile_commands.json", "Makefile" },
}
