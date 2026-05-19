-- ~/.config/nvim/lua/plugins/lang.lua
return {
  -- Auto-close and auto-rename HTML/JSX/TSX tags using Treesitter.
  -- '>' closes the opening tag; renaming an opening tag renames its closing tag in sync.
  {
    "windwp/nvim-ts-autotag",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      opts = {
        enable_close = true,           -- auto-insert closing tag on '>'
        enable_rename = true,          -- keep closing tag in sync when renaming opening tag
        enable_close_on_slash = true,  -- close on '</'
      },
    },
  },

  -- VimTeX: LaTeX editing, compilation, and SyncTeX
  {
    "lervag/vimtex",
    lazy = false, -- Must NOT be lazy-loaded
    init = function()
      -- VimTeX configuration goes in init (before plugin loads)

      -- Use Neovim's built-in syntax highlighting alongside treesitter
      vim.g.vimtex_syntax_enabled = 1
      vim.g.vimtex_syntax_conceal = {
	      accents = 0,
	      ligatures = 0,
	      cites = 0,
	      fancy = 0,
	      greek = 0,
	      math_bounds = 0,
	      math_delimiters = 0,
	      math_fracs = 0,
	      math_super_sub = 0,
	      math_symbols = 0,
	      sections = 0,
	      styles = 0,
      }
      vim.g.tex_flavor = "latex"

      -- Set the PDF viewer to Skim
      vim.g.vimtex_view_method = "skim"

      -- Skim forward search settings
      vim.g.vimtex_view_skim_activate = 1  -- Focus Skim on forward search
      vim.g.vimtex_view_skim_reading_bar = 1  -- Show reading bar in Skim

      -- Compiler settings (use latexmk, matching your texlab config)
      vim.g.vimtex_compiler_method = "latexmk"
      vim.g.vimtex_compiler_latexmk = {
        options = {
          "-pdf",
          "-shell-escape",
          "-verbose",
          "-file-line-error",
          "-synctex=1",  -- CRITICAL: enables SyncTeX
          "-interaction=nonstopmode",
        },
      }

      -- Completion settings (integrates with blink.cmp below)
      vim.g.vimtex_complete_enabled = 1
      vim.g.vimtex_complete_close_braces = 1

      -- Quickfix settings
      vim.g.vimtex_quickfix_mode = 0  -- Don't auto-open quickfix

      -- Disable texlab conflict: let vimtex handle folding/indenting
      vim.g.vimtex_fold_enabled = 0

      -- Neovim server for inverse search (nvr reads this)
      -- Write the server address to a file for nvr to pick up
      vim.g.vimtex_callback_progpath = vim.v.progpath
    end,
  },

  -- blink.cmp: Autocompletion
  {
    "saghen/blink.cmp",
    version = "^1",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    opts = {
      keymap = { preset = "super-tab" },
      appearance = {
        nerd_font_variant = "mono",
        use_nvim_cmp_as_default = true,
      },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
        providers = {
          -- Add VimTeX as a completion source
          vimtex = {
            name = "vimtex",
            module = "blink.cmp.sources.complete_func",
            opts = {
              complete_func = "vimtex#complete#omnifunc",
            },
          },
        },
      },
      completion = {
        documentation = { auto_show = true, auto_show_delay_ms = 200 },
      },
      fuzzy = { implementation = "prefer_rust_with_warning" },
    },
  },
}
