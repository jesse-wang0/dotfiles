# Source all modular Zsh files
for file in $HOME/.dotfiles/zsh/{path,env,python,alias,prompt}.zsh; do
  [ -r "$file" ] && source "$file"
done
unset file
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
source "$(brew --prefix nvm)/nvm.sh"
