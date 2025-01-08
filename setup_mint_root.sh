#!/bin/bash
DC='\033[95m'
NC='\033[0m'
function put_line_to_profile {
    echo $1 >> /etc/bash.bashrc
    echo $1 >> /etc/zsh/zshrc
}


# Instalação dos pacotes gerais
apt update -y && apt upgrade -y
apt-get -y install sudo vim vim-scripts unzip zip p7zip-full htop iotop wget lynx curl locate ssh nano git build-essential zsh rsync apt-transport-https ca-certificates curl software-properties-common gnupg

# Configurando o vim
su -c "echo '' >> /etc/vim/vimrc"
su -c "echo 'syntax on' >> /etc/vim/vimrc"
su -c "echo 'colorscheme elflord' >> /etc/vim/vimrc"


# Configuração do BASH
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
source ~/.bashrc


# Python 3.4
apt-get -y install python3 python3-dev python3-pip python3-venv virtualenvwrapper python3-setuptools
apt-get -y install libncurses5-dev libncursesw5-dev libreadline6-dev libdb-dev libgdbm-dev libsqlite3-dev libssl-dev libbz2-dev libexpat1-dev liblzma-dev zlib1g-dev libxml2-dev libxslt1-dev
put_line_to_profile ''
put_line_to_profile 'export WORKON_HOME=\~/.virtualenvs'
put_line_to_profile 'export PROJECT_HOME=\~/devel'
put_line_to_profile 'source /usr/share/virtualenvwrapper/virtualenvwrapper.sh'


# Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(. /etc/os-release; echo "$UBUNTU_CODENAME") stable"
apt-get update -y
apt-get -y install docker-ce docker-compose
usermod -aG docker $USER
#reboot
#docker --version
#docker-compose --version
#docker run --rm hello-world && docker rmi hello-world

# OpenVPN
apt-get install -y network-manager-openvpn


# Install “Oh My ZSH”
chsh -s $(which zsh)
chsh -s $(which zsh)
zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
sed -i 's/plugins=(git)/plugins=(git virtualenvwrapper zsh-syntax-highlighting zsh-autosuggestions)/g' ~/.zshrc
sed -i 's/robbyrussell/agnoster/g' ~/.zshrc
source ~/.zshrc

# Install Java JDK Eclipse Temurin
wget -O - https://packages.adoptium.net/artifactory/api/gpg/key/public | apt-key add -
echo "deb https://packages.adoptium.net/artifactory/deb focal main" | tee /etc/apt/sources.list.d/adoptium.list
apt-get update
apt-get install -y temurin-17-jdk

# Install PHP 7.4
apt-get -y install make libmcrypt-dev
apt install -y php7.4-dev php7.4-cli php7.4-fpm php7.4-mysql php7.4-pgsql php7.4-curl php7.4-gd php7.4-xml php7.4-xmlrpc php7.4-xsl php7.4-zip php7.4-intl php7.4-json php7.4-ldap php7.4-mbstring php7.4-opcache php7.4-readline php-pear
pecl -q install mcrypt-1.0.5
bash -c "echo extension=/usr/lib/php/20190902/mcrypt.so > /etc/php/7.4/cli/conf.d/mcrypt.ini"
