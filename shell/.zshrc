# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else goes below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ============================================================================
# Oh My Zsh Configuration
# ============================================================================

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
ZSH_DISABLE_COMPFIX="true"
plugins=(git zsh-autosuggestions)

source "$ZSH/oh-my-zsh.sh"

# Load Powerlevel10k configuration
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ============================================================================
# Custom Functions and Aliases
# ============================================================================

# Load all dotfiles functions
for func_file in git k8s terraform telepresence lightspeed general; do
  if [ -f "$HOME/dotfiles/$func_file/.functions" ]; then
    source "$HOME/dotfiles/$func_file/.functions"
  fi
done

# ============================================================================
# Development Tools Setup
# ============================================================================

# Node Version Manager (NVM)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Proto - Tool version manager
export PROTO_HOME="$HOME/.proto"
export PATH="$PROTO_HOME/shims:$PROTO_HOME/bin:$PATH"

# Go
export GOBIN="$HOME/go/bin"
export PATH="$GOBIN:$PATH"

# Node.js options
export NODE_OPTIONS=--max_old_space_size=8192

# ============================================================================
# PATH Configuration
# ============================================================================

export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# Docker
export PATH="/Applications/Docker.app/Contents/Resources/bin:$PATH"

# Google Cloud SDK (if installed)
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then
  source "$HOME/google-cloud-sdk/path.zsh.inc"
fi
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then
  source "$HOME/google-cloud-sdk/completion.zsh.inc"
fi

# ============================================================================
# Command Completion
# ============================================================================

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /opt/homebrew/bin/jinn jinn
