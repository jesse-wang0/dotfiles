#!/bin/bash

# Dotfiles directory
DOTFILES_DIR=~/.dotfiles

# List of dotfiles to symlink
DOTFILES=(
    "git/.gitconfig:$HOME/.gitconfig"
    "zsh/.zshrc:$HOME/.zshrc"
    "p10k/.p10k.zsh:$HOME/.p10k.zsh"
    "conda/.condarc:$HOME/.condarc"
    "aider/.aider.conf.yml:$HOME/.aider.conf.yml"
)

echo "Setting up dotfile symlinks..."

for entry in "${DOTFILES[@]}"; do
    src="${entry%%:*}"
    target="${entry##*:}"
    
    echo "Linking $DOTFILES_DIR/$src to $target"
    
    mkdir -p "$(dirname "$target")"
    ln -sfn "$DOTFILES_DIR/$src" "$target"
done

echo "Symlink setup complete!"
