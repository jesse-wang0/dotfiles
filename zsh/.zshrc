# Load Powerlevel10k Instant Prompt early (must stay near the top)
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Source all modular Zsh files
for file in $HOME/.dotfiles/zsh/{path,env,python,alias}.zsh; do
  [ -r "$file" ] && source "$file"
done
unset file
