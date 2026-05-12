-- ~/.config/nvim/lua/plugins/core.lua
return {
  -- File Explorer
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFindFile", "NvimTreeOpen", "NvimTreeClose" },
    keys = {
      { "<leader>tt", "<cmd>NvimTreeToggle<cr>",   desc = "Toggle file tree" },
      { "<leader>tf", "<cmd>NvimTreeFindFile<cr>", desc = "Focus tree on current file" },
    },
    opts = {
      view = { width = 30 },
      renderer = { group_empty = true },
      filters = { dotfiles = false },
    },
  },

  -- Git signs in sign column + hunk navigation
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      signcolumn = true,
      current_line_blame = false,
    },
    keys = {
      { "<leader>gb", "<cmd>Gitsigns blame_line<cr>",   desc = "Git: blame line" },
      { "<leader>gp", "<cmd>Gitsigns preview_hunk<cr>", desc = "Git: preview hunk" },
      { "]c",         "<cmd>Gitsigns next_hunk<cr>",    desc = "Git: next hunk" },
      { "[c",         "<cmd>Gitsigns prev_hunk<cr>",    desc = "Git: prev hunk" },
    },
  },

  -- Status Line
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = { options = { theme = "auto" } },
  },

  -- Colorscheme: pure-black variant
  {
    "navarasu/onedark.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "dark",
      colors = { bg0 = "#000000" },
    },
    config = function(_, opts)
      require("onedark").setup(opts)
      vim.cmd("colorscheme onedark")
    end,
  },

  -- Treesitter (MAIN branch API — full rewrite, requires Neovim 0.12+).
  -- LaTeX intentionally excluded: VimTeX handles tex highlighting.
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = function() require("nvim-treesitter").update() end,
    config = function()
      local ts = require("nvim-treesitter")
      local wanted = {
        "c", "cpp", "python", "html", "css",
        "javascript", "typescript", "tsx",
        "lua", "vim", "vimdoc", "json", "bash", "markdown",
      }
      -- Only install parsers we don't already have. Skips on warm startup.
      local installed = {}
      for _, p in ipairs(ts.get_installed()) do installed[p] = true end
      local missing = {}
      for _, p in ipairs(wanted) do
        if not installed[p] then table.insert(missing, p) end
      end
      if #missing > 0 then ts.install(missing) end

      -- zsh has no dedicated parser; reuse the bash parser for it.
      vim.treesitter.language.register("bash", "zsh")

      -- Start highlighter on FileType for languages with a parser available.
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "c", "cpp", "python", "html", "css",
                    "javascript", "typescript", "typescriptreact",
                    "lua", "vim", "json", "bash", "sh", "zsh", "markdown" },
        callback = function(args)
          local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
          if lang and pcall(vim.treesitter.start, args.buf, lang) then
            vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })
    end,
  },
}
