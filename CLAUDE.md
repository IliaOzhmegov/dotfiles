# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Personal dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/) for symlinking and [Go Task](https://taskfile.dev/) for automation. All packages are symlinked into `$HOME`.

## Common Commands

```bash
# Link / unlink all packages
task stow
task unstow

# Link / unlink a single package
stow -t ~ <package>
stow -D -t ~ <package>

# Install prerequisites (once)
brew install stow go-task
brew install --cask ghostty claude-code
```

Task targets follow the pattern `setup:<tool>` (installs via Homebrew) and `stow:<tool>` / `unstow:<tool>` (manages symlinks). `setup:*` tasks are idempotent — they skip if the binary already exists.

## Architecture

Each top-level directory (e.g., `nvim/`, `zsh/`, `alacritty/`) is a **Stow package**. Its internal path mirrors the target layout relative to `$HOME`. For example, `nvim/.config/nvim/init.lua` stows to `~/.config/nvim/init.lua`.

Packages not in `Taskfile.yml` (`ideavim`, `zathura`) must be stowed manually with `stow -t ~`.

**Theme:** All tools use **Gruvbox Material** for visual consistency — keep this in mind when adding new tool configs.

## Neovim Config (`nvim/.config/nvim/`)

Built on **lazy.nvim**. Each plugin is an isolated file under `lua/plugins/`; adding a plugin means adding a new file there (or editing the relevant existing one).

```
init.lua               # lazy.nvim bootstrap only
lua/config/
  options.lua          # editor settings (tabs, folding, etc.)
  keymaps.lua          # window nav, resize, diagnostics
  autocmds.lua         # filetype detection, whitespace, dbt support
lua/plugins/
  lsp.lua              # Mason + pyright, sqls, yamlls, lua_ls
  formatting.lua       # ruff, sqlfmt, sqlfluff, prettier (conform.nvim)
  copilot.lua          # GitHub Copilot + CopilotChat
  telescope.lua        # fuzzy finder
  ...                  # one file per plugin group
```

Leader key is `Space`.

### Mason (LSP server manager)

LSP servers (`pyright`, `lua_ls`, `sqls`, `yamlls`) are declared in `ensure_installed` inside `lsp.lua` and **auto-installed by Mason on first Neovim launch** — no brew tasks needed for them. Mason downloads pre-built binaries; Go/cargo do not need to be in PATH.

- To add a new LSP server: add it to `ensure_installed` in `lsp.lua`, configure it with `vim.lsp.config(...)`, and include it in the `vim.lsp.enable(...)` call.
- Do **not** add brew tasks for tools Mason already manages.

## Zsh Config (`zsh/.zshrc`)

Plugin manager: **zinit**. Prompt: **starship** (configured in `starship/`). Vi mode is enabled (`bindkey -v`). The `rr` function wraps yazi with directory persistence.

Key aliases: `v` → nvim, `gs` → git status, `gd` → git diff, `gl` → git log.

## Tmux Config (`tmux/`)

Based on [gpakosz/.tmux](https://github.com/gpakosz/.tmux). **Do not edit `.tmux.conf`** — it is the upstream base. User customizations go in `.tmux.conf.local` only.
