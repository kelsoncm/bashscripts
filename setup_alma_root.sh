#!/bin/bash
DC='\033[95m'
NC='\033[0m'
function put_line_to_profile {
    echo $1 >> /etc/bash.bashrc
    echo $1 >> /etc/zshrc
}


printf "${DC}Install common packages$NC\n"
dnf upgrade -y
dnf install epel-release -y 
dnf install neovim unzip zip htop iotop wget lynx curl mlocate openssh-server openssh-clients nano git zsh rsync util-linux-user net-tools -y


printf "${DC}Configurando o neovim$NC\n"
unlink /usr/bin/vim
ln -s /usr/bin/nvim /usr/bin/vim
echo '' >> /usr/share/nvim/sysinit.vim
echo 'set mouse=i' >> /usr/share/nvim/sysinit.vim


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
su -c "rm -rf /tmp/bashscripts"
source ~/.bashrc


printf "${DC}Install Python os version$NC\n"
dnf -y install python3 python3-pip python3-setuptools
ln -s /usr/bin/python3 /usr/bin/python
ln -s /usr/bin/pip3 /usr/bin/pip
pip install virtualenvwrapper
put_line_to_profile ''
put_line_to_profile '# Python and PyEnv'
put_line_to_profile 'export WORKON_HOME=$HOME/.virtualenvs'
put_line_to_profile 'export PROJECT_HOME=$HOME/devel'
put_line_to_profile 'source /usr/local/bin/virtualenvwrapper.sh'


printf "${DC}Install PyEnv$NC\n"
dnf groupinstall -y "Development Tools"
dnf install -y zlib zlib-devel bzip2-devel openssl-devel sqlite-devel readline-devel python3-tkinter -y
curl https://pyenv.run | bash
put_line_to_profile 'export PYENV_ROOT="$HOME/.pyenv"'
put_line_to_profile '[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"'
put_line_to_profile 'eval "$(pyenv init - bash)"'
put_line_to_profile 'eval "$(pyenv virtualenv-init -)"'


printf "${DC}Install “docker e docker compose plugin”$NC\n"
groupadd docker
usermod -aG docker $USER
yum install -y yum-utils
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
systemctl start docker
wget -O /bin/hadolint https://github.com/hadolint/hadolint/releases/download/v2.12.0/hadolint-Linux-x86_64
chmod +x /bin/hadolint


printf "${DC}Check “docker and docker compose plugin”$NC\n"
docker --version
docker compose version
docker run --rm hello-world


# Install “Oh My ZSH”
chsh -s /bin/zsh
chsh -s /bin/zsh
CHSH=no RUNZSH=no zsh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/popstas/zsh-command-time.git ~/.oh-my-zsh/custom/plugins/command-time
sed -i 's/plugins=(git)/plugins=(git virtualenvwrapper zsh-syntax-highlighting zsh-autosuggestions command-time)/g' ~/.zshrc
sed -i 's/robbyrussell/agnoster/g' ~/.zshrc
zsh


printf "${DC}Userful infos$NC\n"
echo "Se lembre de adicionar este OS ao suporte no Docker Desktop"
echo "Para instalar uma nova versão: pyenv install 3.12 -f"
echo "Para criar um novo venv chamado “ava” usando Python 3.12: pyenv virtualenv 3.12 ava"
echo "Para ativar o venv “ava”: pyenv activate ava"
