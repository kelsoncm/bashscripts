#!/bin/bash

# Esse script tem a finalidade de inserir um Servidor Debian 8 no dominio ifrn.local
echo "Por favor autentique com a senha sudo"
sudo -v

if ! $(sudo which realmd 2>/dev/null); then
    sudo aptitude install realmd adcli sssd
fi

if ! $(sudo which ntpd 2>/dev/null); then
    sudo aptitude install ntp
fi

sudo mkdir -p /var/lib/samba/private
DOMAIN="ifrn.local"

echo "Por favor digite o login para ingressar no dominio: "
read ADMIN

sudo realm join --user=$ADMIN $DOMAIN

if [ $? -ne 0 ]; then
    echo "AD join failed.  Please run 'journalctl -xn' to determine why."
    exit 1
fi

sudo systemctl enable sssd
sudo systemctl start sssd

echo "session required pam_mkhomedir.so skel=/etc/skel/ umask=0022" | sudo tee -a /etc/pam.d/common-session

# configure sudo
sudo aptitude install libsss-sudo

echo "%domain\ admins@$DOMAIN ALL=(ALL) ALL" | sudo tee -a /etc/sudoers.d/domain_admins
 
echo "The computer is joined to the domain.  Please reboot, ensure that you are connected to the network, and you should be able to login with domain credentials."

