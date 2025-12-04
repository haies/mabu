cd
yum -y update
sudo yum install -y yum-utils \
  device-mapper-persistent-data \
  lvm2&&
sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo&&
sudo yum -y install docker-ce&&
sudo mkdir /etc/docker&&
wget https://haies.cn/assets/daemon.json -O /etc/docker/daemon.json&&
sudo systemctl start docker&&
sudo systemctl enable docker&&
sudo curl -L https://get.daocloud.io/docker/compose/releases/download/1.25.4/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose&&
sudo chmod +x /usr/local/bin/docker-compose&&
# sudo curl -L "https://github.com/docker/compose/releases/download/1.23.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose&&
# chmod +x /usr/local/bin/docker-compose&&
sudo usermod -aG docker `id -un`