######################################################
## Basic scripts for new arch - linux based distros ##
######################################################

#-------------------Steps-------------------------#
# 1. Install pre requisites
# 2. Install yay and snap -- I like having both as an option
# 3. Install vscode
# 4. Install zsh and zsh - plugins
# 5. Install nvim and source nvim - config and nodejs and node based depenecies 
# 6. Install python3
# 8. Install tmux and source tmux config
# 9. Install fonts 
# 10. Install chrome/brave
# 11. Install pfetch 


# /bin/bash
#Install pre-requisites
installprereq(){
    # Pre-requi
    echo "Installing base-devel"
    sudo pacman -S base-devel 
     
    echo "Installing git"
    sudo pacman -S git  cmake unzip ninja tree-sitter
    
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
    echo "Moving new zsh config"
    cp config-files/zshrc ${HOME}/.zshrc

    if [ -d "${HOME}/.config/alacritty/" ] ; then 
        echo "Changing old alacritty to alacritty.old and setting up new alacritty config" 
        if [ -d "${HOME}/.config/alacritty/alacritty.yml" ] ; then
            mv ${HOME}/.config/alacritty/alacritty.yml ${HOME}/.config/alacritty/alacritty.old.yml
        fi
    else
        echo "Making alacritty config dir"
        mkdir -p ${HOME}/.config/alacritty/
    fi
    echo "Moving new alacritty config"
    cp config-files/alacritty.yml ${HOME}/.config/alacritty/
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
    if [ -d "${HOME}/.oh-my-zsh/custom/plugins/zsh-z" ] ; then 
        echo "zsh-z already installed... Moving on!"
    else 
        echo "Installing zsh-z."
        git clone https://github.com/agkozak/zsh-z ${HOME}/.oh-my-zsh/custom/plugins/zsh-z
    fi

    if [ -d "${HOME}/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ] ; then 
        echo "zsh-autosuggestions already installed... Moving on!"
    else 
        echo "Installing zsh-autosuggestions."
        git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:- ${HOME}/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    fi

    if [ -d "${HOME}/.oh-my-zsh/custom/plugins/zsh-completions" ] ; then 
        echo "zsh-autocompletion already installed... Moving on!"
    else 
        echo "Installing zsh-autocompletions."
        git clone https://github.com/zsh-users/zsh-completions  ${HOME}/.oh-my-zsh/custom/plugins/zsh-completions
    fi

    if [ -d "${HOME}/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ] ; then 
        echo "zsh-syntax-highlighting already installed... Moving on!"
    else 
        echo "Installing zsh-syntax-highlighting."
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:- ${HOME}/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

    fi
}

installneovim(){
    if yay -Qi neovim-git > /dev/null  ; then
        echo "Neovim already exist... Moving on!"
    else
        yay -S neovim-git
    fi

    if [ -d "${HOME}/.config/nvim" ] ; then 
        echo "Neovim config pre-exists! Consider moving your config!"
    else 
        echo "Cloning github config..."
        bash <(curl -s https://raw.githubusercontent.com/ChristianChiarulli/lunarvim/master/utils/installer/install.sh)

        # read answer
	    # [ "$answer" != "${answer#[Yy]}" ] && installnode
    fi
}

# install NerdFont
installnerdfont(){  
    if yay -Qi ttf-fira-code > /dev/null ; then
        echo "Fira Code Nerd Font already installed... Moving on!"
    else 
        echo "Installing Fira Code Nerd Font"
        yay -S ttf-fira-code
    fi
    echo "fc-cache -f"
    fc - cache - f
}


fixdircolors(){
    #dir color using dircolors.ansi - dark
    echo "Fixing dir-colors"
    if [ !  -e "${HOME}/.dircolors" ]; then
        echo "Fixing Dir Colors"
        curl https://raw.githubusercontent.com/seebi/dircolors-solarized/master/dircolors.ansi-dark --output ${HOME}/.dircolors
    else
        echo "DirColors already exists"
    fi; 
}


installgooglechrome(){
    if yay -Qi google-chrome > /dev/null ; then
        echo "Chrome already exist... Moving on!"
    else
        echo "Installing google-chrome"
        yay -S google-chrome
    fi
}

installpython3(){
    if yay -Qi python3 > /dev/null ; then 
        echo "Python 3 already exist. .. Moving on!"
    else 
        echo "Installing python3 ..."
        yay -S python3
    fi
}

installtmux(){
    if yay -Qi tmux > /dev/null ; then
        echo "Tmux already exist... Moving on!"
    else 
        echo "Installing tmux"
        yay -S tmux
    fi

    if [ -d ${HOME}/.tmux.conf ]; then
        echo "Renaming old tmux configuration to .tmux.conf.old."
        mv ${HOME}/.tmux.conf ${HOME}/tmux.conf.old
    fi

    if [ -d "${HOME}/tmux" ] ; then
        echo "Tmux config exists... setting new config!"
    else     
        echo "Fetching new tmux config."
        git clone https://github.com/gpakosz/.tmux.git ${HOME}/tmux
    
    ln -s -f ${HOME}/tmux/.tmux.conf
    cp ${HOME}/tmux/.tmux.conf.local ${HOME}/
    fi 
    

}

installpfetche(){
    if [ ! -d ${HOME}/.local/pfetch/ ] ; then 
        echo "Installing pfetch ..."
        mkdir -p ${HOME}/.local/pfetch/
        git clone https://github.com/dylanaraps/pfetch ${HOME}/.local/pfetch
        cd ${HOME}/.local/pfetch/ && sudo make install 
        source ${HOME}/.zshrc
    else
        echo "pfetch already exist... please make!"
    fi


}

# adding JAVA_HOME path
# echo "export JAVA_HOME=/usr/lib/jvm/java-version" >> ${HOME}/.bash_profile
# echo "export JAVA_HOME=/usr/lib/jvm/java-version" >> ${HOME}/.zshrc


main(){
    installprereq
    installyay
    moveconfigfiles
    installzsh
    installneovim
    installgooglechrome
    installnerdfont
    fixdircolors
    installpython3
    installtmux
    installpfetche
}
main