-- ~/.config/nvim/lua/plugins/core.lua
return {
  -- File Explorer
  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      view = { width = 30 },
      renderer = { group_empty = true },
      filters = { dotfiles = false },
    },
  },

  -- Status Line
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
      options = { theme = "auto" },
    },
  },

  -- Syntax Highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      ensure_installed = {
        "c", "python", "html", "css", "javascript", "latex", "lua", "vim"
      },
      highlight = { enable = true },
      indent = { enable = true },
    },
  },
}
