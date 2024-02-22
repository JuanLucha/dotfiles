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
plugins=(git jump brew colored-man-pages fast-syntax-highlighting zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# User configuration

ZSH_DISABLE_COMPFIX="true"

# Safe rm command to move to trash folder instead of oblivion
function trash () { command mv "$@" ~/.Trash ; }

# Job aliases
alias com='ssh -AX wpcom'
alias uni='unison -ui text -repeat watch automattic-sandbox'
alias jc="code projects/plugins/jetpack"
alias jt="jurassictube -u juanlucha -s jurassic-john -h localhost:80"
alias jt-break="jurassictube -b -s jurassic-john"
alias jl="tail -f tools/docker/wordpress/wp-content/debug.log"
alias js="jetpack rsync jetpack wpdev@juanlucha.dev.dfw.wordpress.com:~/public_html/wp-content/mu-plugins/jetpack-plugin/production"
alias jb="jetpack build plugins/jetpack"
alias jw="jetpack watch plugins/jetpack"
alias jd="jetpack docker up"

# Personal aliases
alias dev='tmux rename-window dev && sh /Users/lucha/dotfiles/tmux-dev-layout.sh'
alias df='cd /Users/lucha/dotfiles && tmux rename-window config && sh tmux-dev-layout.sh'
alias vim='nvim'
alias v='nvim'
alias t='/Users/juanlucha/dotfiles/reset-tmux.sh'
alias matrix='ssh root@68.183.73.49'

# Vim integration
bindkey -v

bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^r' history-incremental-search-backward

# precmd() { RPROMPT="" }
# function zle-line-init zle-keymap-select {
#    VIM_PROMPT="%{$fg_bold[yellow]%} [% NORMAL]%  %{$reset_color%}"
#    RPS1="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/} $EPS1"
#    zle reset-prompt
# }

# zle -N zle-line-init
# zle -N zle-keymap-select

export KEYTIMEOUT=1

export PATH="$HOME/.local/bin:$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# Making more space for operations like tests
export NODE_OPTIONS=“--max-old-space-size=8192”

export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# Autosuggest keybinding
bindkey '^ ' autosuggest-accept

# pnpm
export PNPM_HOME="/Users/juanlucha/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/juanlucha/miniforge3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/juanlucha/miniforge3/etc/profile.d/conda.sh" ]; then
        . "/Users/juanlucha/miniforge3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/juanlucha/miniforge3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# PHP-VERSION
source $(brew --prefix php-version)/php-version.sh
php-version 8
export PATH="/opt/homebrew/opt/openjdk@11/bin:$PATH"
export SBT_OPTS="-DsocksProxyHost=127.0.0.1 -DsocksProxyPort=8080 -Duser.timezone=UTC"
export JAVA_HOME="/opt/homebrew/Cellar/openjdk@11/11.0.16.1_1/libexec/openjdk.jdk/Contents/Home"
export PATH="/opt/homebrew/opt/php@7.4/bin:$PATH"
export PATH="/opt/homebrew/opt/php@7.4/sbin:$PATH"
export PATH="/opt/homebrew/opt/php@7.2/bin:$PATH"
export PATH="/opt/homebrew/opt/php@7.2/sbin:$PATH"
export PATH="/opt/homebrew/opt/php@7.2/bin:$PATH"
export PATH="/opt/homebrew/opt/php@7.2/sbin:$PATH"
