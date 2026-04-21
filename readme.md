# My dotfiles

Managed with [GNU Stow](https://www.gnu.org/software/stow/) and [Task](https://taskfile.dev/).

## Prerequisites

```bash
brew install stow go-task
```

## Packages

| Package    | What it manages                        |
|------------|----------------------------------------|
| alacritty  | `~/.config/alacritty/alacritty.toml`   |
| zsh        | `~/.zshrc`                             |
| starship   | `~/.config/starship.toml`              |
| nvim       | `~/.config/nvim/`                      |
| yazi       | `~/.config/yazi/`                      |
| tmux       | `~/.tmux.conf`, `~/.tmux.conf.local`   |
| ideavim    | `~/.ideavimrc`                         |
| zathura    | `~/.config/zathura/zathurarc`          |

## Usage

```bash
# Link all packages
task stow

# Unlink all packages
task unstow

# Link a single package
stow -t ~ <package>
```

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

## Resources

- [Oh My Zsh + Powerlevel10k setup](https://dev.to/abdfnx/oh-my-zsh-powerlevel10k-cool-terminal-1no0)
