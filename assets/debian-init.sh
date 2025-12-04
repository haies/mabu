cd
sudo bash -c "cat > /etc/apt/sources.list"<<EOF
deb https://mirrors.aliyun.com/debian/ `env -i bash -c '. /etc/os-release; echo $VERSION_CODENAME'` main non-free contrib
deb https://mirrors.aliyun.com/debian/ `env -i bash -c '. /etc/os-release; echo $VERSION_CODENAME'`-updates main non-free contrib
deb https://mirrors.aliyun.com/debian/ `env -i bash -c '. /etc/os-release; echo $VERSION_CODENAME'`-backports main non-free contrib
deb-src https://mirrors.aliyun.com/debian/ `env -i bash -c '. /etc/os-release; echo $VERSION_CODENAME'` main non-free contrib
deb-src https://mirrors.aliyun.com/debian/ `env -i bash -c '. /etc/os-release; echo $VERSION_CODENAME'`-updates main non-free contrib
deb-src https://mirrors.aliyun.com/debian/ `env -i bash -c '. /etc/os-release; echo $VERSION_CODENAME'`-backports main non-free contrib
deb https://mirrors.aliyun.com/debian-security/ `env -i bash -c '. /etc/os-release; echo $VERSION_CODENAME'`/updates main non-free contrib
deb-src https://mirrors.aliyun.com/debian-security/ `env -i bash -c '. /etc/os-release; echo $VERSION_CODENAME'`/updates main non-free contrib
EOF
echo "Changed sources.list to mirrors.aliyun.com";

sh -c "$(wget -qO- https://haies.cn/assets/apt-install.sh)"
# sed -i '0,/plugins=(git)/s/plugins=(git)/plugins=(git z tmux docker)/' .zshrc&&
# source .zshrc
# curl -sL https://deb.nodesource.com/setup_12.x | bash -&&
# apt-get install -y nodejs&&
# echo "Installed Nodejs and NPM" &&

# sudo npm i tldr -g && tldr -u &&
# echo "Installed NPM tools";

echo "All Done!";