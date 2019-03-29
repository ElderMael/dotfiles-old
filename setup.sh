#!/usr/bin/env bash

set -ex

if [ -z "${ZSH_CUSTOM}" ]; then
    echo "\$ZSH_CUSTOM was not imported"
    exit 1
fi

bullettrain_theme_url="http://raw.github.com/caiogondim/bullet-train-oh-my-zsh-theme/master/bullet-train.zsh-theme"

mkdir -p "${ZSH_CUSTOM}/themes"

http --follow "${bullettrain_theme_url}" \
     > "${ZSH_CUSTOM}/themes/bullet-train.zsh-theme"

# Setting Up Git
git config --global user.email "sftwr.mael@gmail.com"
git config --global user.name "ElderMael"
git config --global core.editor "emacs"

set +x # Next command is very verbose!
curl -s "https://get.sdkman.io" | zsh
set -x

/usr/bin/env zsh ./install
