#!/bin/bash

set -ex

echo "Setting up software"

mkdir -p temp-installs
cd temp-installs

if  ! fc-list | grep -q "Powerline" ; then
    echo "Install Powerline patched fonts"
    git clone https://github.com/powerline/fonts.git
    cd fonts
    ./install.sh
    cd ..
    rm -rf fonts
fi

if [ "$(uname)" == "Darwin" ]; then
    echo "Installing Mac Software"
fi

if [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then

    echo "Installing Linux Software"
    sudo apt-get -y update
    sudo apt-get -y upgrade

    if  ! type "zsh" >/dev/null; then
	echo "Installing ZSH for user $(echo $SUDO_USER)"
        sudo apt-get install -y zsh
        chsh -s $(which zsh) # Set As Default Shell
    fi

    if ! type "curl" >/dev/null ; then
        sudo apt-get install -y curl
    fi

    if ! type "emacs" >/dev/null ; then
        sudo apt-get install -y emacs
    fi

    if [ ! -d "${HOME}/.oh-my-zsh" ]; then
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
        mkdir -p "${HOME}/.oh-my-zsh/custom/themes"
        wget -O ~/.oh-my-zsh/custom/themes/bullet-train.zsh-theme http://raw.github.com/caiogondim/bullet-train-oh-my-zsh-theme/master/bullet-train.zsh-theme
    fi

    if ! type "terminator" >/dev/null ; then
      sudo apt-get install -y terminator
    fi

    # Installing Other Software
    if ! type "emacs" >/dev/null ; then
        sudo apt-get install -y emacs
    fi

    if ! type "google-chrome" >/dev/null; then
      wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
      sudo dpkg -i google-chrome-stable_current_amd64.deb
      sudo apt-get -y -f install
    fi

    if ! type "http" >/dev/null; then
        sudo apt-get install -y httpie
    fi

    if ! type "openpyn" >/dev/null; then
        # This gets stuck in ubuntu artful...
        # See https://bugs.launchpad.net/ubuntu/+source/openvpn/+bug/1725525
        sudo apt-get install -y openvpn python-gobject unzip wget
        sudo apt-get install -y python3-pip
        sudo pip3 install openpyn
    fi

    if ! type "obs" >/dev/null; then
        sudo apt-get install -y obs-studio
    fi

    if ! type "dconf-editor" >/dev/null; then
        sudo apt-get install -y dconf-editor
    fi

    if ! type "screenfetch" >/dev/null; then
        sudo apt-get install -y screenfetch
    fi

fi

# Setting Up Git
git config --global user.email "sftwr.mael@gmail.com"
git config --global user.name "ElderMael"
git config --global core.editor "emacs"

if type nvm >/dev/null; then

    # Node Version Manager And Node
    wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | zsh

    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

    nvm install stable

fi

if type sdk >/dev/null; then
    # SDK MAN and Java/Ceylon
    curl -s "https://get.sdkman.io" | bash
    source "${HOME}/.sdkman/bin/sdkman-init.sh"

    sdk install java
    sdk install ceylon
    sdk install gradle


    echo "Linking dotfiles"
fi

cd ..
bash ./install
