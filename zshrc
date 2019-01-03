# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Theme
ZSH_THEME="bullet-train"

BULLETTRAIN_EXEC_TIME_ELAPSED=2
BULLETTRAIN_CONTEXT_BG=red
BULLETTRAIN_CONTEXT_FG=white

BULLETTRAIN_PROMPT_ORDER=(
     time
     status
     custom
     context
     dir
     git
     cmd_exec_time
 )

# Plugins
plugins=(
    git
    nyan
    command-not-found
    git-extras
    gradle
    httpie
    rand-quote
 )

# Oh-My-ZSH
source $ZSH/oh-my-zsh.sh

# Aliases
alias zshconfig="emacs ~/.zshrc"
alias ohmyzsh="emacs ~/.oh-my-zsh"
alias ll="ls -lah"
alias nordvpn="systemctl start openpyn"
alias docker-obliterate-containers="docker ps -a -q | xargs docker stop \
      && docker ps -a -q | xargs docker rm "
alias glw='./gradlew'

#Editor
EDITOR=emacs


# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# SDK MAN
[[ -s "${HOME}/.sdkman/bin/sdkman-init.sh" ]] && source "${HOME}/.sdkman/bin/sdkman-init.sh"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

export ATOMIST_ROOT=/home/necromancer/Repos
