# Astheria's Dotfiles

Personal configuration files for my Arch Linux + Hyprland setup.

## Structure

```
~/.dotfiles/
├── .zshrc              # Zsh shell configuration
├── .p10k.zsh           # Powerlevel10k theme config
├── .gitconfig          # Git user configuration
├── .gitignore
├── README.md
└── config/
    ├── hypr/           # Hyprland WM config
    │   ├── hyprland.conf
    │   ├── hyprlock.conf
    │   ├── hypridle.conf
    │   └── scripts/    # Custom shell scripts
    ├── nvim/           # Neovim (Kickstart.nvim based)
    ├── kitty/          # Kitty terminal
    ├── ghostty/        # Ghostty terminal
    ├── tmux/           # Tmux multiplexer
    ├── rofi/           # Rofi app launcher
    ├── waybar/         # Waybar status bar
    ├── swaync/         # Sway notification center
    ├── fastfetch/      # System info display
    ├── btop/           # System monitor
    ├── cava/           # Audio visualizer
    ├── wofi/           # Alternative launcher
    ├── nwg-displays/   # Display manager
    ├── waypaper/       # Wallpaper manager
    └── user-dirs.dirs  # XDG user directories
```

## Installation

### Manual Symlink Method

```bash
# Backup existing configs (if any)
mv ~/.config/hypr ~/.config/hypr.bak
mv ~/.config/nvim ~/.config/nvim.bak
# ... repeat for other configs

# Create symlinks
ln -s ~/.dotfiles/.zshrc ~/.zshrc
ln -s ~/.dotfiles/.p10k.zsh ~/.p10k.zsh
ln -s ~/.dotfiles/.gitconfig ~/.gitconfig
ln -s ~/.dotfiles/config/hypr ~/.config/hypr
ln -s ~/.dotfiles/config/nvim ~/.config/nvim
ln -s ~/.dotfiles/config/kitty ~/.config/kitty
ln -s ~/.dotfiles/config/ghostty ~/.config/ghostty
ln -s ~/.dotfiles/config/tmux ~/.config/tmux
ln -s ~/.dotfiles/config/rofi ~/.config/rofi
ln -s ~/.dotfiles/config/waybar ~/.config/waybar
ln -s ~/.dotfiles/config/swaync ~/.config/swaync
ln -s ~/.dotfiles/config/fastfetch ~/.config/fastfetch
ln -s ~/.dotfiles/config/btop ~/.config/btop
ln -s ~/.dotfiles/config/cava ~/.config/cava
ln -s ~/.dotfiles/config/wofi ~/.config/wofi
ln -s ~/.dotfiles/config/nwg-displays ~/.config/nwg-displays
ln -s ~/.dotfiles/config/waypaper ~/.config/waypaper
```

### One-liner (with backup)

```bash
# Run from ~/.dotfiles directory
for dir in config/*/; do
  name=$(basename "$dir")
  [ -e ~/.config/"$name" ] && mv ~/.config/"$name" ~/.config/"$name".bak
  ln -s "$PWD/$dir" ~/.config/"$name"
done
ln -s "$PWD/.zshrc" ~/.zshrc
ln -s "$PWD/.p10k.zsh" ~/.p10k.zsh
ln -s "$PWD/.gitconfig" ~/.gitconfig
```

## Key Components

- **WM**: Hyprland with custom animations, gestures, and multi-monitor support
- **Bar**: Waybar with custom CSS styling
- **Terminal**: Kitty (primary) + Ghostty
- **Editor**: Neovim (Kickstart.nvim with LSP, Telescope, blink.cmp)
- **Shell**: Zsh + Powerlevel10k + autosuggestions + syntax highlighting
- **Multiplexer**: Tmux with TPM (resurrect + continuum)
- **Launcher**: Rofi
- **Notifications**: SwayNC
- **Wallpaper**: Waypaper (awww backend)
- **Display**: nwg-displays

## Dependencies

```bash
# Core
hyprland waybar rofi swaync kitty ghostty tmux

# Tools
fastfetch btop cava neovim eza bat zoxide starship

# AUR helpers (yay)
yay -S hyprlock hypridle cliphist grim slurp wl-clipboard
```

## Notes

- Tmux plugins are managed by TPM (Tmux Plugin Manager)
- Neovim has its own git history (Kickstart.nvim fork)
- Browser configs excluded (contain state/cache data)
- GTK/KDE configs excluded (environment-specific)
