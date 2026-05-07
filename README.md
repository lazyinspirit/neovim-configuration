Lightweight neovim configuration for editing python/html/javascript/c/c++ scripts.
For editing and compiling latex, make sure to do the following:
1. Download the appropriate latex compiler, e.g. mactex
2. Download Skim for displaying PDF
3. Open Skim -> Settings -> Sync, tick both Check for file changes and Reload automatically, Preset: Custom, Command: /usr/local/bin/skim-nvr.sh, Arguments: %line "%file"
4. Create skim-nvr.sh in /usr/local/bin, copy and paste the following:
#!/bin/bash
LINE="$1"
FILE="$2"
SERVER=$(cat /tmp/vimtexserver.txt)
/opt/homebrew/bin/nvim --server "$SERVER" --remote "$FILE"
sleep 0.1
/opt/homebrew/bin/nvim --server "$SERVER" --remote-send "${LINE}G"
| Column1. To compile a tex file, do <space>+x in normal mode
5. To forward search, double click on neovim
6. To inverse search, do cmd + shift + left click
