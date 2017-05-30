# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Theme
ZSH_THEME="bullet-train"

# Plugins
plugins=(git)

# Oh-My-ZSH
source $ZSH/oh-my-zsh.sh

# Aliases
alias emacs='emacs --no-window'
alias zshconfig="emacs ~/.zshrc"
alias ohmyzsh="emacs ~/.oh-my-zsh"


# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# SDK MAN
[[ -s "${HOME}/.sdkman/bin/sdkman-init.sh" ]] && source "${HOME}/.sdkman/bin/sdkman-init.sh"

