#!/bin/bash
DC='\033[95m'
NC='\033[0m'


printf "${DC}Check “docker and docker compose plugin”$NC\n"
docker run --rm hello-world
docker rmi hello-world
docker --version
docker compose version


printf "${DC}Install “Oh My ZSH”$NC\n"
CHSH=no RUNZSH=no zsh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
chsh -s $(which zsh)
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/popstas/zsh-command-time.git ~/.oh-my-zsh/custom/plugins/command-time
sed -i 's/plugins=(git)/plugins=(git virtualenvwrapper zsh-syntax-highlighting zsh-autosuggestions command-time)/g' ~/.zshrc
sed -i 's/robbyrussell/agnoster/g' ~/.zshrc


printf "${DC}Install “PyEnv”$NC\n"
curl https://pyenv.run | bash
rm ~/.pyenv/completions/pyenv.bash


printf "${DC}Loading “ZSH” first time$NC\n"
zsh
