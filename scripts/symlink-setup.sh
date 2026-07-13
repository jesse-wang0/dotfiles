#!/usr/bin/env bash

set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BACKUP_SUFFIX="backup.$(date +%Y%m%d%H%M%S)"

DOTFILES=(
    "git/.gitconfig:$HOME/.gitconfig"
    "zsh/.zshrc:$HOME/.zshrc"
    "conda/.condarc:$HOME/.condarc"
)

RETIRED_TARGETS=(
    "$HOME/.p10k.zsh"
    "$HOME/.aider.conf.yml"
)

link_file() {
    local src_rel="$1"
    local target="$2"
    local source="$DOTFILES_DIR/$src_rel"

    if [[ ! -e "$source" ]]; then
        echo "Missing source: $source" >&2
        exit 1
    fi

    mkdir -p "$(dirname "$target")"

    if [[ -L "$target" ]]; then
        local current_target
        current_target="$(readlink "$target")"

        if [[ "$current_target" == "$source" ]]; then
            echo "Already linked: $target"
            return
        fi

        echo "Replacing symlink: $target -> $source"
        rm "$target"
    elif [[ -e "$target" ]]; then
        local backup="$target.$BACKUP_SUFFIX"
        echo "Backing up existing file: $target -> $backup"
        mv "$target" "$backup"
    fi

    echo "Linking: $target -> $source"
    ln -s "$source" "$target"
}

cleanup_retired_target() {
    local target="$1"

    if [[ ! -L "$target" ]]; then
        return
    fi

    local current_target
    current_target="$(readlink "$target")"

    case "$current_target" in
        "$DOTFILES_DIR"/aider/*|"$DOTFILES_DIR"/p10k/*)
            echo "Removing retired symlink: $target"
            rm "$target"
            ;;
    esac
}

echo "Setting up dotfile symlinks..."

for entry in "${DOTFILES[@]}"; do
    src="${entry%%:*}"
    target="${entry##*:}"

    link_file "$src" "$target"
done

for target in "${RETIRED_TARGETS[@]}"; do
    cleanup_retired_target "$target"
done

echo "Symlink setup complete!"
