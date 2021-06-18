######################################################
## Basic scripts for new arch - linux based distros ##
######################################################

#-------------------Steps-------------------------#
# 1. Install pre requisites
# 2. Install yay and snap -- I like having both as an option
# 3. Install vscode
# 4. Install zsh and zsh - plugins
# 5. Install nvim and source nvim - config
# 6. Install python3
# 7. Install NodeJs and neovim node dependencies
# 8. Install tmux and source tmux config
# 9. Install fonts 

# /bin/bash
#Install pre-requisites
installprereq(){
    # Pre-requi
    echo "Installing base-devel"
    sudo pacman -S base-devel 
     
    echo "Installing git"
    sudo pacman -S git 
    
}

# Installing yay 
installyay() {
    if pacman -Qi yay-git > /dev/null ; then
        echo "Yay already exists... Moving on!"        
    else
        echo "Installing Yay ...."
        cd /opt/
        sudo git clone https://aur.archlinux.org/yay-git.git
        sudo chown -R $USER:users ./yay-git
        cd yay-git
        makepkg -si
    fi
    
}

installsnap(){
    if sudo pacman Qi snapd > /dev/null ; then
        echo "Snap already exists... Moving on!"
    else 
        sudo pacman -S snapd
        sudo systemctl enable --now snapd.socket
    fi
}   

installvscode(){ 
    sudo snap install code --classic 
}

moveconfigfiles(){ 
    if [ -d "${HOME}/.zshrc" ]  ; then 
        echo "Changing old zshrc to zshrc.old and setting up new zshrc"
        mv ${HOME}/.zshrc ${HOME}/zshrc.old
    fi
    cp configfiles/zshrc ${HOME}/.zshrc

    if [ -d "${HOME}/.config/alacritty/alacritty.yml" ] ; then 
        echo "Changing old alacritty to alacritty.old and setting up new alacritty config"
        mv ${HOME}/.config/alacritty/alacritty.yml ${HOME}/.config/alacritty/alacritty.old.yml
    fi
    cp configfiles/alacritty.yml ${HOME}/.config/alacritty/
}

installzsh(){
    if pacman -Qi zsh > /dev/null ; then
        echo "ZSH already exist... Moving on!"
    else
        echo "Installing ZSH"
        sudo pacman -S zsh 
        chsh -s $(which zsh)
    fi

    if [ -d "${HOME}/.oh-my-zsh" ] ; then 
        echo "oh-my-zsh already exists... Moving on!"
    else 
        echo "Installing oh-my-zsh."
        if pacman -Qi curl > /dev/null ; then
             sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
        elif pacman -Qi wget > /dev/null ; then
            sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
      
        else 
            echo "Skipping oh-my-zsh. Please install either curl or wget"
        fi
    fi


    echo "Setting up zsh plugins"
    # installing oh - my - zsh plugins:zsh - z, zsh - autosuggestions, zsh - completions, zsh - syntax - highlighting 
    if [ -d "${HOME}/.oh-my-zsh/custom}/plugins/zsh-z" ] ; then 
        echo "zsh-z already installed... Moving on!"
    else 
        echo "Installing zsh-z."
        git clone https://github.com/agkozak/zsh-z $ZSH_CUSTOM/plugins/zsh-z
    fi

    if [ -d "${HOME}/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ] ; then 
        echo "zsh-autosuggestions already installed... Moving on!"
    else 
        echo "Installing zsh-autosuggestions."
        git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:- ${HOME}/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    fi

    if [ -d "${HOME}/.oh-my-zsh/custom}/plugins/zsh-completions" ] ; then 
        echo "zsh-autocompletion already installed... Moving on!"
    else 
        echo "Installing zsh-autocompletions."
        git clone https://github.com/zsh-users/zsh-completions  ${HOME}/.oh-my-zsh/custom}/plugins/zsh-completions
    fi

    if [ -d "${HOME}/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" ] ; then 
        echo "zsh-syntax-highlighting already installed... Moving on!"
    else 
        echo "Installing zsh-syntax-highlighting."
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:- ${HOME}/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

    fi
}

installneovim(){
    if [ -d "${HOME}/.config/nvim" ] ; then 
        echo "Neovim config pre-exists" 
    fi
}


# install nodejs
installnodeJS(){
    echo "Installing NodeJs"
    curl - sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
    sudo apt - get install - y nodejs
}

# install NerdFont
# installnerdfont(){  
#     echo "Installing FirCode Nerd Font"
#     fonts_dir = "${HOME}/.local/share/fonts"
#     if [ !  - d "${fonts_dir}" ]; then
#         echo "mkdir -p $fonts_dir"
#         mkdir - p "${fonts_dir}"
#     else
#         echo "Found fonts dir $fonts_dir"
#     fi
# }


# for type in Bold Light Medium Regular Retina; do
#   file_path = "${HOME}/.local/share/fonts/FiraCode-${type}.ttf"
#      file_url = "https://github.com/tonsky/FiraCode/blob/master/distr/ttf/FiraCode-${type}.ttf?raw=true"
# if [ !  - e "${file_path}" ]; then
#         echo "wget -O $file_path $file_url"
#         wget - O "${file_path}" "${file_url}"
#     else
#   echo "Found existing file $file_path"
#     fi; 
# done

# echo "fc-cache -f"
# fc - cache - f


# #dir color using dircolors.ansi - dark
# echo "Fixing dir-colors"


# if [ !  - e "${HOME}/.dircolors" ]; then
#         echo "Fixing Dir Colors"
#         curl https://raw.githubusercontent.com/seebi/dircolors-solarized/master/dircolors.ansi-dark --output {HOME}/.dircolors
# else
#         echo "DirColors already exists"
#     fi; 
# }


# adding JAVA_HOME path
# echo "export JAVA_HOME=/usr/lib/jvm/java-version" >> {HOME}/.bash_profile
# echo "export JAVA_HOME=/usr/lib/jvm/java-version" >> {HOME}/.zshrc

installprereq
installyay
moveconfigfiles
installzsh
# installneovim