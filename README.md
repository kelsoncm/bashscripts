# My default setups

This tutorial teaches you how to install my default packages, which are: `sudo`, `vim`, `vim-scripts`, `neovim`, `unzip`, `zip`, `p7zip-full`, `htop`, `iotop`, `wget`, `curl`, `lynx`, `locate`, `ssh`, `nano`, `git`, `build-essential`, `zsh`, `rsync`, `bash`, `python3`, `python3-dev`, `python3-pip`, `python3-venv`, `virtualenvwrapper`, `python3-setuptools`, `libncurses5-dev`, `libncursesw5-dev`, `libreadline6-dev`, `libdb-dev`, `libgdbm-dev`, `libsqlite3-dev`, `libssl-dev`, `libbz2-dev`, `libexpat1-dev`, `liblzma-dev`, `zlib1g-dev`, `libxml2-dev`, `libxslt1-dev`, `Oh My ZSH`, `PyEnv`, `linux-image-generic`, `apt-transport-https`, `ca-certificates`, `software-properties-common`, `docker`, `hadolint` e `docker compose plugin`.

In addition to configures `bash`, `zsh`, `vim`, `virtualenv-wrapper` e `Oh My ZSH`.


## Debian

```bash
sudo addgroup docker && sudo adduser $USER && sudo adduser $USER docker
sudo apt update && sudo apt upgrade -y && sudo apt install -y curl sudo bash && cat /etc/os-release && cat /etc/debian_version
sudo bash -c "$(curl -fsSL https://raw.githubusercontent.com/kelsoncm/bashscripts/refs/heads/main/debian/setup_root.sh)"
bash -c "$(curl -fsSL https://raw.githubusercontent.com/kelsoncm/bashscripts/refs/heads/main/debian/setup_user.sh)"
```

## AlmaLinux
```bash
sudo su -
dnf upgrade -y dnf install curl sudo bash -y
bash -c "$(curl -fsSL https://raw.githubusercontent.com/kelsoncm/bashscripts/refs/heads/main/alma/setup_root.sh)"
# se for usar k8s, k9s e helm
bash -c "$(curl -fsSL https://raw.githubusercontent.com/kelsoncm/bashscripts/refs/heads/main/alma/setup_k8s.sh)"
exit
bash -c "$(curl -fsSL https://raw.githubusercontent.com/kelsoncm/bashscripts/refs/heads/main/alma/setup_user.sh)"
```

To install PHP 8 https://reintech.io/blog/install-php-8-centos-9

### Install node 20
```bash
sudo dnf update -y
curl -sL https://rpm.nodesource.com/setup_20.x | sudo bash -
sudo dnf install nodejs -y
node -v
```

## Para apagar a WSL
Uninstall using Windows "Add or Remove Programs" and then in `cmd`:

```bash
wsl -l -v
wsl --unregister Debian
wsl --unregister AlmaLinux-9
```

## To install a pyenv specific venv

```bash
curl https://pyenv.run | bash
sudo apt install -y tk-dev libffi-dev
pyenv install -f 3.13
pyenv virtualenv 3.13 projectname
pyenv activate project
python --version
```
