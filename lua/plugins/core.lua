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

  -- Colorscheme: black background, red/green/blue/yellow/purple/grey palette [1]
  {
    "navarasu/onedark.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "dark", -- pure black background variant
      colors = {
        bg0 = "#000000", -- force true black background
      },
    },
    config = function(_, opts)
      require("onedark").setup(opts)
      vim.cmd("colorscheme onedark")
    end,
  },

  -- Syntax Highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      ensure_installed = {
        "c", "python", "html", "css", "javascript", "lua", "vim"
        -- latex excluded: VimTeX handles LaTeX highlighting
      },
      highlight = {
        enable = true,
        disable = { "latex" },
      },
      indent = { enable = true },
    },
  },
}
