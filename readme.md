# My dotfiles

Managed with [GNU Stow](https://www.gnu.org/software/stow/) and [Task](https://taskfile.dev/).

## Prerequisites

```bash
brew install stow go-task
```

## Packages

| Package    | What it manages                        |
|------------|----------------------------------------|
| alacritty  | `~/.config/alacritty/alacritty.yml`    |
| nvim       | `~/.config/nvim/`                      |
| ranger     | `~/.config/ranger/`                    |
| tmux       | `~/.tmux.conf`, `~/.tmux.conf.local`   |
| zsh        | `~/.zshrc`                             |
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

## Resources

- [Oh My Zsh + Powerlevel10k setup](https://dev.to/abdfnx/oh-my-zsh-powerlevel10k-cool-terminal-1no0)
