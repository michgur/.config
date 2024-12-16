# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# to bind this file, run
# ln -s ~/.config/.zshrc ~/.zshrc

eval "$(/opt/homebrew/bin/brew shellenv)"

export PATH="/Users/michaelgur/Library/Python/3.9/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"

export ICLOUD="$HOME/Library/Mobile Documents/com~apple~CloudDocs"
export STUDIES="$ICLOUD/לימודים/העברית/2025א"

bindkey -v
source $HOMEBREW_PREFIX/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh

# if in ZED, don't use p10k
if [ -z "$ZED" ]; then
  source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme
  # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
  [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
fi
