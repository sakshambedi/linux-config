# /bin/bash
# installing oh-my-zsh plugins: zsh-z, zsh-autosuggestions, zsh-completions, zsh-syntax-highlighting 
git clone https://github.com/agkozak/zsh-z $ZSH_CUSTOM/plugins/zsh-z
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting


# 
echo "Installing NodeJs"
curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
sudo apt-get install -y nodejs

echo "Installing FirCode Nerd Font"
fonts_dir="${HOME}/.local/share/fonts"
if [ ! -d "${fonts_dir}" ]; then
    echo "mkdir -p $fonts_dir"
    mkdir -p "${fonts_dir}"
else
    echo "Found fonts dir $fonts_dir"
fi

for type in Bold Light Medium Regular Retina; do
    file_path="${HOME}/.local/share/fonts/FiraCode-${type}.ttf"
    file_url="https://github.com/tonsky/FiraCode/blob/master/distr/ttf/FiraCode-${type}.ttf?raw=true"
    if [ ! -e "${file_path}" ]; then
        echo "wget -O $file_path $file_url"
        wget -O "${file_path}" "${file_url}"
    else
  echo "Found existing file $file_path"
    fi;
done

echo "fc-cache -f"
fc-cache -f


#dir color using dircolors.ansi-dark
echo "Fixing dir-colors"

if [ ! -e "${HOME}/.dircolors" ]; then
    echo "Fixing Dir Colors"
    curl https://raw.githubusercontent.com/seebi/dircolors-solarized/master/dircolors.ansi-dark --output ~/.dircolors
else
    echo "DirColors already exists"
fi;

# adding JAVA_HOME path
echo "export JAVA_HOME=/usr/lib/jvm/java-version" >> ~/.bash_profile
echo "export JAVA_HOME=/usr/lib/jvm/java-version" >> ~/.zshrc

