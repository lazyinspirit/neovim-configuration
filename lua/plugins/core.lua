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
    config = function()
      -- Pressing Enter on a directory expands it and changes Neovim's CWD.
      local function on_attach(bufnr)
        local api = require('nvim-tree.api')
        api.config.mappings.default_on_attach(bufnr)
        vim.keymap.set('n', '<CR>', function()
          local node = api.tree.get_node_under_cursor()
          if node and node.type == 'directory' then
            vim.cmd.cd(node.absolute_path)
          end
          api.node.open.edit()
        end, { buffer = bufnr, noremap = true, silent = true, desc = "Open / cd into dir" })
      end
      require('nvim-tree').setup({
        on_attach = on_attach,
        view     = { width = 30 },
        renderer = { group_empty = true },
        filters  = { dotfiles = false },
      })
    end,
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

  -- Status line + per-window winbar with a clickable ✕ close button
  -- in the top-right corner of every (non-utility) pane.
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        theme = "auto",
        -- Skip winbar on plugin/utility windows where a close X would be
        -- confusing or duplicate existing UI. Statusline is unaffected.
        disabled_filetypes = {
          winbar = { "NvimTree", "TelescopePrompt", "lazy", "mason", "help", "qf" },
        },
      },
      -- Statusline sections. These are the lualine defaults plus a cwd
      -- component prepended to `lualine_c` so the working directory is
      -- always visible. `fnamemodify(..., ":~")` shows the path with
      -- $HOME collapsed to ~ for readability.
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = {
          {
            function() return vim.fn.fnamemodify(vim.fn.getcwd(), ":~") end,
            icon = "",
          },
          "filename",
        },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
      -- Inactive panes also show cwd + filename. Defaults only show
      -- filename, so we mirror the active layout for "at all times".
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {
          {
            function() return vim.fn.fnamemodify(vim.fn.getcwd(), ":~") end,
            icon = "",
          },
          "filename",
        },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      -- `lualine_z` is the rightmost winbar section — gives us the
      -- top-right corner of each pane.
      winbar = {
        lualine_z = {
          {
            function() return " ✕ " end,
            -- Lualine on_click signature: (component_id, button, modifiers).
            -- Only the primary (left) mouse button should close.
            on_click = function(_, button)
              if button ~= "l" then return end
              if vim.fn.winnr("$") > 1 then
                vim.cmd("close")     -- close just this split
              else
                vim.cmd("bdelete")   -- last window — drop the buffer, keep Neovim open
              end
            end,
          },
        },
      },
      -- Same button on inactive panes so the user doesn't have to focus
      -- a pane before closing it.
      inactive_winbar = {
        lualine_z = {
          {
            function() return " ✕ " end,
            on_click = function(_, button)
              if button ~= "l" then return end
              if vim.fn.winnr("$") > 1 then
                vim.cmd("close")
              else
                vim.cmd("bdelete")
              end
            end,
          },
        },
      },
    },
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

  -- Draggable vertical scrollbar. Click the thumb and drag with the mouse
  -- to scroll long files. Relies on `mouse = "a"` from lua/options.lua.
  {
    "dstein64/nvim-scrollview",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      base = "right",            -- flush with the right edge of each window
      signs_on_startup = {},     -- cursor-position thumb only — no git/diag/search marks
      winblend = 30,             -- partial transparency so the bar doesn't hide text under it
      excluded_filetypes = { "NvimTree", "TelescopePrompt", "lazy", "mason" },
      always_show = false,       -- hide on buffers that fit on screen
    },
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
