cd
sudo bash -c "cat > /etc/apt/sources.list"<<EOF
deb https://mirrors.aliyun.com/ubuntu/ `lsb_release -cs` main restricted universe multiverse
deb https://mirrors.aliyun.com/ubuntu/ `lsb_release -cs`-security main restricted universe multiverse
deb https://mirrors.aliyun.com/ubuntu/ `lsb_release -cs`-updates main restricted universe multiverse
# deb https://mirrors.aliyun.com/ubuntu/ `lsb_release -cs`-proposed main restricted universe multiverse
deb https://mirrors.aliyun.com/ubuntu/ `lsb_release -cs`-backports main restricted universe multiverse
deb-src https://mirrors.aliyun.com/ubuntu/ `lsb_release -cs` main restricted universe multiverse
deb-src https://mirrors.aliyun.com/ubuntu/ `lsb_release -cs`-security main restricted universe multiverse
deb-src https://mirrors.aliyun.com/ubuntu/ `lsb_release -cs`-updates main restricted universe multiverse
#deb-src https://mirrors.aliyun.com/ubuntu/ `lsb_release -cs`-proposed main restricted universe multiverse
deb-src https://mirrors.aliyun.com/ubuntu/ `lsb_release -cs`-backports main restricted universe multiverse
EOF
sh -c "$(wget -qO- http://haies.cn/assets/apt-install.sh)"
# sed -i '0,/plugins=(git)/s/plugins=(git)/plugins=(git z tmux)/' .zshrc&&
# source .zshrc
# curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash - &&
# sudo apt-get install -y nodejs build-essential &&
# echo "Installed Nodejs and NPM" &&

# sudo npm i tldr -g && tldr -u &&
# echo "Installed NPM tools";

echo "All Done!";
