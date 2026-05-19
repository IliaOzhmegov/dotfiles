# My dotfiles

[Homebrew](https://brew.sh/)
Ghossty and Claude:
```bash
brew install --cask ghostty claude-code
```

Managed with [GNU Stow](https://www.gnu.org/software/stow/) and [Task](https://taskfile.dev/).

## Prerequisites

```bash
brew install stow go-task
```

## Packages

| Package    | What it manages                        |
|------------|----------------------------------------|
| ghostty    | `~/.config/ghostty/config`             |
| alacritty  | `~/.config/alacritty/alacritty.toml`   |
| karabiner  | `~/.config/karabiner/karabiner.json`   |
| ssh        | `~/.ssh/config`                        |
| git        | `~/.gitconfig`                         |
| zsh        | `~/.zshrc`                             |
| starship   | `~/.config/starship.toml`              |
| nvim       | `~/.config/nvim/`                      |
| yazi       | `~/.config/yazi/`                      |
| tmux       | `~/.tmux.conf`, `~/.tmux.conf.local`   |
| ideavim    | `~/.ideavimrc`                         |
| zathura    | `~/.config/zathura/zathurarc`          |

## Usage

```bash
# Fresh machine setup
task setup   # install all tools via Homebrew
task stow    # link all configs

# Unlink all packages
task unstow

# Link a single package
stow -t ~ <package>
```

## Neovim

Modular config built on **lazy.nvim**. Each plugin is a separate file under `lua/plugins/`.

### Structure

```
nvim/.config/nvim/
├── init.lua                     # Bootstrap lazy.nvim
├── lua/config/
│   ├── options.lua              # Editor settings
│   ├── keymaps.lua              # Key mappings
│   └── autocmds.lua             # Auto-commands (python indent, dbt detection)
└── lua/plugins/
    ├── colorscheme.lua          # gruvbox-material
    ├── telescope.lua            # Fuzzy finder
    ├── treesitter.lua           # Syntax highlighting
    ├── lsp.lua                  # pyright, sqlls, yamlls, lua_ls
    ├── completion.lua           # nvim-cmp + snippets
    ├── git.lua                  # gitsigns + fugitive
    ├── copilot.lua              # Copilot + CopilotChat
    ├── formatting.lua           # ruff, sqlfmt, sqlfluff, prettier
    └── ui.lua                   # lualine, which-key, indent guides, nvim-tree
```

### Key mappings

| Key | Action |
|-----|--------|
| `Space` | Leader key |
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep |
| `<leader>fb` | Buffers |
| `<leader>e` | Toggle file explorer |
| `gd` | Go to definition |
| `gr` | References |
| `K` | Hover documentation |
| `<leader>rn` | Rename symbol |
| `<leader>ca` | Code action |
| `<leader>bf` | Format buffer |
| `<leader>cc` | Toggle Copilot Chat |
| `<leader>ce` | Copilot explain (visual) |
| `<leader>cr` | Copilot review (visual) |
| `Ctrl+y` | Accept Copilot suggestion |

## fzf cheatsheet

### Keybindings

| Shortcut   | Action                              |
|------------|-------------------------------------|
| `Ctrl+R`   | Fuzzy search command history        |
| `Ctrl+T`   | Fuzzy find files                    |
| `Alt+C`    | Fuzzy find and cd into a directory  |
| `**<Tab>`  | Fuzzy completion (works everywhere) |

### Tab completion examples

```bash
cd **<Tab>       # fuzzy pick directory
vim **<Tab>      # fuzzy pick file
kill **<Tab>     # fuzzy pick process
ssh **<Tab>      # fuzzy pick host
```

### Pipe anything into fzf

```bash
# Fuzzy-pick a git branch to checkout
git branch | fzf | xargs git checkout

# Fuzzy-pick a process to kill
ps aux | fzf | awk '{print $2}' | xargs kill

# Preview files while searching
fzf --preview 'cat {}'
```

## Dadbod (BigQuery)

vim-dadbod is configured as a SQL query runner from within Neovim (`<leader>db` to toggle UI, `<leader>E` to run a query).

Table listing in the sidebar does **not work** with BigQuery — querying `INFORMATION_SCHEMA.TABLES` requires project-level permissions that are not available. Use the Cloud Console for schema/table browsing.

Connection URL format: `bigquery:<project-id>`

## Resources

- [Oh My Zsh + Powerlevel10k setup](https://dev.to/abdfnx/oh-my-zsh-powerlevel10k-cool-terminal-1no0)
