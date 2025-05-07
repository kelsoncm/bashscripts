#!/bin/bash


# Install “Oh My ZSH”
chsh -s /bin/zsh
chsh -s /bin/zsh
zsh
CHSH=no RUNZSH=no zsh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/popstas/zsh-command-time.git ~/.oh-my-zsh/custom/plugins/command-time
sed -i 's/plugins=(git)/plugins=(git virtualenvwrapper zsh-syntax-highlighting zsh-autosuggestions command-time)/g' ~/.zshrc
sed -i 's/robbyrussell/agnoster/g' ~/.zshrc
source ~/.zshrc


printf "${DC}Install PyEnv$NC\n"
rm -rf ~/.pyenv
curl https://pyenv.run | bash
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc
echo '[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc
echo 'eval "$(pyenv init - bash)"' >> ~/.zshrc
echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.zshrc
rm -rf ~/.pyenv/completions/pyenv.bash 
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc
echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n eval "$(pyenv init -)"\nfi' >> ~/.zshrc
source ~/.zshrc

# Test “docker e docker compose plugin”
docker --version
docker compose version
docker run --rm hello-world
echo "Se lembre de adicionar o Alma ao suporte no Docker Desktop"
