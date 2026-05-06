# Configuration Files

This repository contains my personal configuration files for macOS and Linux terminals.

## Contents

- `bash_profile` - Login shell entry point for macOS
- `bashrc` - Interactive shell configuration for macOS/Linux
- `ghostty-config` - Ghostty terminal emulator settings
- `shirotellin` - Custom light theme for Ghostty
- `gh-dash-config` - GitHub CLI dashboard configuration

## Shirotelin Theme

The Shirotelin theme was not available for Ghostty, so I designed my own light theme based on the original Shirotelin colorscheme. It provides a clean, minimalist light theme for the terminal.

## Setup

To use these configs, copy the relevant files to your home directory:

```bash
cp bashrc ~/.bashrc
cp bash_profile ~/.bash_profile
cp ghostty-config ~/.config/ghostty/config
```

## Requirements

- Homebrew (macOS)
- Starship prompt
- Zellij terminal multiplexer
- fzf for fuzzy finding
- kubectl for Kubernetes
- Ghostty terminal emulator

## License

Personal configuration files - use at your own risk.