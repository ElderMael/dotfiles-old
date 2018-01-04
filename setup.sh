#!/bin/bash

set -ex

toolbox_binary_path="${HOME}/.local/share/JetBrains/Toolbox/bin/jetbrains-toolbox"
toolbox_url="https://download.jetbrains.com/toolbox/jetbrains-toolbox-1.6.2914.tar.gz"
vagrant_deb_url="https://releases.hashicorp.com/vagrant/2.0.1/vagrant_2.0.1_x86_64.deb"
slack_binary_url="https://downloads.slack-edge.com/linux_releases/slack-desktop-3.0.0-amd64.deb"
oh_my_zsh_url="https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh"
chrome_deb_url="https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb > chrome.deb"
bullettrain_theme_url="http://raw.github.com/caiogondim/bullet-train-oh-my-zsh-theme/master/bullet-train.zsh-theme"
packer_zip_url="https://releases.hashicorp.com/packer/1.1.3/packer_1.1.3_linux_amd64.zip"

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

    if ! type "emacs" >/dev/null; then
        brew cask install emacs
    fi

    if ! type "zsh" >/dev/null; then
        brew install zsh
        chsh -s $(which zsh)
    fi

fi

if [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then

    echo "Installing Linux Software"
    sudo apt-get -y update
    sudo apt-get -y upgrade

    if ! type "http" >/dev/null; then
        sudo apt-get install -y httpie
    fi

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
        sh -c "$(curl -fsSL "${oh_my_zsh_url}")"
        mkdir -p "${HOME}/.oh-my-zsh/custom/themes"
        http "${bullettrain_theme_url}" \
             > "${HOME}/.oh-my-zsh/custom/themes/bullet-train.zsh-theme"
    fi

    if ! type "terminator" >/dev/null ; then
      sudo apt-get install -y terminator
    fi

    # Installing Other Software
    if ! type "emacs" >/dev/null ; then
        sudo apt-get install -y emacs
    fi

    if ! type "google-chrome" >/dev/null; then
      http "${chrome_deb_url}"
      set +e  
      sudo dpkg -i chrome.deb
      set -e
      sudo apt-get -y -f install
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

    if [ ! -f "${toolbox_binary_path}"  ]; then
        http "${toolbox_url}" > toolbox.tar.gz

        tar xvzf toolbox.tar.gz --strip=1 # Extract Binary Only
        chmod u+x jetbrains-toolbox

        ./jetbrains-toolbox
    fi

    if ! type "tree" >/dev/null; then
        sudo apt-get -y install tree
    fi

    if ! dpkg -l | grep vlc >/dev/null; then
        sudo apt-get install -y git-extras
    fi

    if ! type "slack" >/dev/null; then
        http "${slack_binary_url}" > slack.deb

        sudo dpkg -i slack.deb
        sudo apt-get -y -f install
    fi

    if ! type "VirtualBox" >/dev/null; then
        sudo apt-get -y install virtualbox
    fi

    if ! type "vagrant" >/dev/null; then
        http "${vagrant_deb_url}" > vagrant.deb

        sudo dpkg -i vagrant.deb
        sudo apt-get -y -f install
    fi

    if ! type "packer" >/dev/null; then
        http "${packer_zip_url}" > packer.zip

        unzip packer.zip

        sudo cp -f packer /usr/bin/packer
        sudo chmod 555 /usr/bin/packer
    fi

fi

# Setting Up Git
git config --global user.email "sftwr.mael@gmail.com"
git config --global user.name "ElderMael"
git config --global core.editor "emacs"

if [ ! -d "${HOME}/.nvm/" ]; then

    # Node Version Manager And Node
    wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | zsh

    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

    nvm install stable

fi

if [ ! -d "${HOME}/.sdkman" ]; then
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
