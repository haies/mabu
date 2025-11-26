sudo apt-get update ;
sudo apt-get install -y  git zsh ;

echo y | sh -c "$(wget -qO- http://haies.cn/assets/install-zsh.sh)" &&
echo "Installed oh-my-zsh" &&

sed -i '0,/plugins=(git)/s/plugins=(git)/plugins=(git z tmux)/' .zshrc&&
sudo sed -i '$a   \unsetopt BG_NICE' .zshrc && #:解决nice(5) failed: operation not permitted
sudo source .zshrc &&
echo "Updated oh-my-zsh plugins";

sudo apt-get upgrade -y ;
sudo apt-get install -y vim git zsh p7zip-full tmux curl rsync tree htop nmap zip man;
echo "Installed basic tools" ;