# ~/.bash_profile — login shell entry point
# Set up login-only environment, then delegate to ~/.bashrc for interactive features.

# Homebrew shellenv (sets PATH, MANPATH, INFOPATH, HOMEBREW_* vars)
eval "$(/opt/homebrew/bin/brew shellenv)"

# Source ~/.bashrc so login shells get the same interactive setup as non-login shells.
[ -f "$HOME/.bashrc" ] && source "$HOME/.bashrc"
