# Path to your oh-my-zsh installation.

export ZSH_CUSTOM="${HOME}/.oh-my-zsh/custom"

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
alias purge-package='sudo dpkg --remove --forceall'

#Editor
EDITOR=emacs


export ATOMIST_ROOT=/home/necromancer/Repos
