yum -y update
sudo yum -y install git zsh tmux epel-release&&
sudo yum -y install p7zip p7zip-plugins htop rsync&&
# curl -L https://github.com/docker/compose/releases/download/1.23.2/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
echo y | sh -c "$(wget http://haies.cn/assets/install-zsh.sh -O -)"&&
sed -i '0,/plugins=(git)/s/plugins=(git)/plugins=(git z tmux docker)/' .zshrc&&
# sudo sed -i '65c   plugins=(git z tmux extrat)' .zshrc &&
source .zshrc
