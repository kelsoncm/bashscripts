#!/bin/bash
DC='\033[95m'
NC='\033[0m'
function put_line_to_profile {
    echo $1 >> /etc/bash.bashrc
    echo $1 >> /etc/zsh/zshrc
}


printf "${DC}Install common packages$NC\n"
apt -y update && apt -y upgrade
apt-get -y install sudo vim vim-scripts unzip zip p7zip-full htop iotop wget curl lynx locate ssh nano git build-essential zsh rsync


printf "${DC}Configurando o neovim$NC\n"
echo '' >> /etc/vim/vimrc
echo 'syntax on' >> /etc/vim/vimrc
echo 'colorscheme elflord' >> /etc/vim/vimrc


printf "${DC}Configuração do BASH$NC\n"
cd /tmp
git clone https://bitbucket.org/kelsoncm/bashscripts.git
mv /tmp/bashscripts/bash* /etc/
chmod a+x /etc/bash_*
mv /tmp/bashscripts/current_branch /usr/bin/
chmod a+x /usr/bin/current_branch
put_line_to_profile ''
put_line_to_profile '. /etc/bash_alias'
put_line_to_profile '. /etc/bash_alias_git'
put_line_to_profile '. /etc/bash_prompt'
su -c "rm -rf /tmp/bashscripts"


printf "${DC}Install Python os version$NC\n"
apt-get -y install python3 python3-dev python3-pip python3-venv virtualenvwrapper python3-setuptools libncurses5-dev libncursesw5-dev libreadline6-dev libdb-dev libgdbm-dev libsqlite3-dev libssl-dev libbz2-dev libexpat1-dev liblzma-dev zlib1g-dev libxml2-dev libxslt1-dev
ln -s /usr/bin/python3 /usr/bin/python
put_line_to_profile ''
put_line_to_profile '# Python and PyEnv'
put_line_to_profile 'export WORKON_HOME=~/.virtualenvs'
put_line_to_profile 'export PROJECT_HOME=~/devel'
put_line_to_profile 'source /usr/share/virtualenvwrapper/virtualenvwrapper.sh'


printf "${DC}Install PyEnv$NC\n"
apt install -y tk-dev libffi-dev
curl https://pyenv.run | bash
put_line_to_profile 'export PYENV_ROOT="$HOME/.pyenv"'
put_line_to_profile '[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"'
put_line_to_profile 'eval "$(pyenv init - bash)"'
put_line_to_profile 'eval "$(pyenv virtualenv-init -)"'
pyenv versions


printf "${DC}Install “docker e docker compose plugin”$NC\n"
apt remove docker docker-engine docker.io
apt install -y linux-image-generic apt-transport-https ca-certificates software-properties-common docker.io
wget -O /bin/hadolint https://github.com/hadolint/hadolint/releases/download/v2.12.0/hadolint-Linux-x86_64
chmod +x /bin/hadolint


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
zsh
