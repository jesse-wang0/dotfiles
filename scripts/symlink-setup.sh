#!/bin/bash

# Dotfiles directory
DOTFILES_DIR=~/.dotfiles

# List of dotfiles to symlink - add new entries here following the pattern
declare -A DOTFILES=(
    [git/.gitconfig]="$HOME/.gitconfig"
    [zsh/.zshrc]="$HOME/.zshrc"
)

echo "Setting up dotfile symlinks..."
for file in "${!DOTFILES[@]}"; do
    target="${DOTFILES[$file]}"
    echo "Linking $DOTFILES_DIR/$file to $target"
    
    # Create parent directory if needed
    mkdir -p "$(dirname "$target")"
    
    # Create symlink (-sf: force overwrite, -n: treat LINK_NAME as normal file if it's a symlink)
    ln -sfn "$DOTFILES_DIR/$file" "$target"
done

echo "Symlink setup complete!"
