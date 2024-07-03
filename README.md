# My default setups


## Debian

### As root
```bash
addgroup docker && adduser kelson && adduser kelson docker
apt update && apt upgrade -y && apt install -y curl sudo bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/kelsoncm/bashscripts/master/debian_first_install)"
```

### As my user
```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/kelsoncm/bashscripts/master/debian_first_install)"
```
