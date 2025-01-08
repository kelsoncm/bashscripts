# My default setups


## Debian

### First as root
```bash
addgroup docker && adduser kelson && adduser kelson docker
apt update && apt upgrade -y && apt install -y curl sudo bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/kelsoncm/bashscripts/master/debian_first_install)"
```

curl https://pyenv.run | bash
sudo apt install -y tk-dev libffi-dev
pyenv install -f 3.13
pyenv virtualenv 3.13 projectname
pyenv activate project
python --version


### Them as my own user
```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/kelsoncm/bashscripts/master/debian_user_setup)"
```


## AlmaLinux

### First as root
```bash
dnf upgrade -y dnf install curl sudo bash -y && reboot
bash -c "$(curl -fsSL https://raw.githubusercontent.com/kelsoncm/bashscripts/master/alma_first_install_root)"
```

### Them as my own user
```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/kelsoncm/bashscripts/master/alma_first_install_user)"
```
