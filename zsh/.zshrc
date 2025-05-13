# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# to bind this file, run
# ln -s ~/.config/.zshrc ~/.zshrc

eval "$(/opt/homebrew/bin/brew shellenv)"

export ICLOUD="$HOME/Library/Mobile Documents/com~apple~CloudDocs"
export STUDIES="$ICLOUD/לימודים/העברית/2025ב"

bindkey -v
source /opt/homebrew/opt/fzf/shell/key-bindings.zsh
source /opt/homebrew/opt/fzf/shell/completion.zsh
source /opt/homebrew/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh

source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export CLICOLOR=1

autoload -Uz add-zsh-hook
add-zsh-hook precmd () {
  bindkey '^R' fzf-history-widget
}
