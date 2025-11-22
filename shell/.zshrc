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
