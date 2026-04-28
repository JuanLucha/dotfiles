# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="af-magic"


# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git jump brew colored-man-pages fast-syntax-highlighting zsh-autosuggestions poetry autoenv)

source $ZSH/oh-my-zsh.sh

# User configuration

ZSH_DISABLE_COMPFIX="true"

# Safe rm command to move to trash folder instead of oblivion
function trash () { command mv "$@" ~/.Trash ; }

# Personal aliases
alias t='tmux ls 2>/dev/null | grep -q . && tmux a || tmux'
alias tk='tmux kill-server'
alias matrix='ssh root@68.183.73.49'
alias v='nvim'
alias vim='nvim'
alias p3='python3'
alias red='ssh lucha@matrix.johnfightgaming.com -p 2314'

# Vim integration
bindkey -v

bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^r' history-incremental-search-backward

export KEYTIMEOUT=1

export PATH="$HOME/.local/bin:$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# Making more space for operations like tests
export NODE_OPTIONS=“--max-old-space-size=8192”

export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export PATH="/opt/homebrew/opt/openjdk@11/bin:$PATH"
export SBT_OPTS="-DsocksProxyHost=127.0.0.1 -DsocksProxyPort=8080 -Duser.timezone=UTC"
export JAVA_HOME=$(/usr/libexec/java_home -v 17)
export PATH="$JAVA_HOME/bin:$PATH"

## Pyenv config
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# Activate python environments on entering folders that includes an env folder themselves

# Function to activate automatically a virtual environment
function auto_activate_virtualenv() {
    if [[ -d "./env" && -f "./env/bin/activate" ]]; then
        # Desactiva cualquier entorno virtual activo previamente
        deactivate 2>/dev/null
        
        # Activa el entorno virtual
        source ./env/bin/activate
        echo "Virtual environment './env' activated."
    fi
}

# Activate the function changing the directory
autoload -U add-zsh-hook
add-zsh-hook chpwd auto_activate_virtualenv

# Executes the function on terminal startup
auto_activate_virtualenv

# Android sdk
export ANDROID_HOME="$HOME/Library/Android/sdk"
export PATH="$PATH:$ANDROID_HOME/platform-tools"
export PATH="$PATH:$ANDROID_HOME/emulator"

# Autosuggest keybinding
bindkey '^ ' autosuggest-accept

export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export PATH="/opt/homebrew/opt/openjdk@17/bin:$PATH"

# Added by Windsurf
export PATH="/Users/lucha/.codeium/windsurf/bin:$PATH"
export NDK_HOME="$ANDROID_HOME/ndk/27.1.12297006"

# Added by Antigravity
export PATH="/Users/lucha/.antigravity/antigravity/bin:$PATH"
