-- ~/.config/nvim/lsp/clangd.lua
return {
  name = "clangd",
  cmd = { "clangd" },
  filetypes = { "c", "cpp", "objc", "objcpp" },
  root_markers = { ".clangd", "compile_commands.json", "compile_flags.txt", "Makefile", "CMakeLists.txt", ".git" },
}
