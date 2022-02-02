# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH=/Users/lucha/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"


# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git jump brew colored-man-pages fast-syntax-highlighting zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# User configuration

ZSH_DISABLE_COMPFIX="true"

export NVM_DIR="$HOME/.nvm"
  [ -s "/usr/local/opt/nvm/nvm.sh" ] && \. "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# Safe rm command to move to trash folder instead of oblivion
function trash () { command mv "$@" ~/.Trash ; }

# Job aliases
alias bo='cd /Users/lucha/code/back-office'
alias fe='cd /Users/lucha/code/skilling-fe'
alias ss='cd /Users/lucha/code/skilling-site'
alias ci='cd /Users/lucha/code/ci-scripts'
alias tv='cd /Users/lucha/code/forex-trading-fe'
alias st='cd /Users/lucha/code/system-tests'
alias ib='cd /Users/lucha/code/partner-fe'

# Personal aliases
alias dev='tmux rename-window dev && sh /Users/lucha/dotfiles/tmux-dev-layout.sh'
alias df='cd /Users/lucha/dotfiles && tmux rename-window config && sh tmux-dev-layout.sh'
alias vim='nvim'
alias sb='cd /Users/lucha/Dropbox/second-brain && vim index.md'

# Vim integration
bindkey -v

bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^r' history-incremental-search-backward

precmd() { RPROMPT="" }
function zle-line-init zle-keymap-select {
   VIM_PROMPT="%{$fg_bold[yellow]%} [% NORMAL]%  %{$reset_color%}"
   RPS1="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/} $EPS1"
   zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select

export KEYTIMEOUT=1

export PATH="$HOME/.local/bin:$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# Making more space for operations like tests
export NODE_OPTIONS=“--max-old-space-size=8192”

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

