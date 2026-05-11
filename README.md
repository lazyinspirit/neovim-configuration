# Neovim configuration

Lightweight Neovim config for editing Python, Lua, C/C++, HTML/CSS/JS/TS,
and LaTeX. Treesitter highlighting, native LSP, format-on-save, Telescope
fuzzy-finder, Git signs, and a fully-wired VimTeX + Skim SyncTeX flow.

Requires **Neovim 0.12+** and **macOS** (paths assume Apple Silicon Homebrew
at `/opt/homebrew`).

## Setup

### 1. Clone the config

```bash
git clone <repo-url> ~/.config/nvim
```

On first launch, `nvim` auto-installs `lazy.nvim`, all plugins, and the
required treesitter parsers (~30s).

### 2. Install LSP servers and formatters

These are NOT auto-installed — they live outside the config directory.

```bash
# Python type-checker + linter/formatter
brew install pyright ruff

# Lua LSP + formatter
brew install lua-language-server stylua

# C/C++ formatter (clangd ships with Xcode tools)
brew install clang-format

# JS/TS/HTML/CSS LSPs + prettier (requires Node — brew install node)
npm install -g typescript typescript-language-server \
               vscode-langservers-extracted \
               prettier
```

Verify with `:LspInfo` after opening a file of the relevant type.

### 3. LaTeX + Skim (forward/inverse search)

1. Install MacTeX (or another TeX distribution): `brew install --cask mactex`.
2. Install Skim: `brew install --cask skim`.
3. Open Skim → Settings → Sync. Tick **Check for file changes** and
   **Reload automatically**. Preset: **Custom**.
   - Command: `/usr/local/bin/skim-nvr.sh`
   - Arguments: `%line "%file"`
4. Create `/usr/local/bin/skim-nvr.sh` with the following contents and make
   it executable (`chmod +x`):

   ```bash
   #!/bin/bash
   LINE="$1"
   FILE="$2"
   SERVER=$(cat /tmp/vimtexserver.txt)
   /opt/homebrew/bin/nvim --server "$SERVER" --remote "$FILE"
   sleep 0.1
   /opt/homebrew/bin/nvim --server "$SERVER" --remote-send "${LINE}G"
   ```

5. Workflow:
   - Compile a `.tex` file: `<space>x` (normal mode).
   - Forward search (jump from cursor to PDF location): double-click in Neovim, or `<space>lv`.
   - Inverse search (jump from PDF to source): cmd + shift + left-click in Skim.

## Recent updates

- **Treesitter rewritten** for the `main` branch of `nvim-treesitter`
  (incompatible with the old `master` branch). Parsers now actually install
  and the highlighter activates per filetype.
- **HTML LSP fixed** — config file was misnamed `lsp/web.lua`; renamed to
  `lsp/html.lua` so `vim.lsp.enable("html")` finds it.
- **Duplicate plugin specs removed** (`cmp.lua`, `treesitter.lua` deletions).
- **Editor defaults added** (`lua/options.lua`): line numbers, indent,
  search behavior, undofile, clipboard, mouse, etc.
- **LSP keymaps added** (`lua/lsp_attach.lua`): `gd`, `gr`, `K`,
  `<leader>rn`, `<leader>ca`, `[d`/`]d`, `<leader>f`.
- **New plugins**: Telescope (`<leader>ff/fg/fb/fh/fr`), Gitsigns
  (`<leader>gb/gp`, `]c`/`[c`).
- **Tree keymap**: `<leader>tt` toggles, `<leader>tf` reveals current file.
- **Format-on-save** via `conform.nvim`. `:FormatDisable` (buffer) or
  `:FormatDisable!` (global) to opt out; `:FormatEnable` to re-enable.
- **JS/TS/CSS LSPs added** (`ts_ls`, `cssls`).
- **Python LSP stack**: `pyright` (types) + `ruff` (lint), with
  `ruff_format` as the formatter for speed (~50ms vs. `black`'s ~5s
  cold-start).
- **`vim.loop` → `vim.uv`** in init.lua (deprecation fix).
