# systemctl start NetworkManage&&
# nmcli con mod eth0 ipv4.dns "223.6.6.6 172.31.79.1"&&
# nmcli con up eth0&&
sudo sh -c "echo -e "DNS1=223.6.6.6\nDNS2=8.8.8.8">>/etc/sysconfig/network-scripts/ifcfg-eth0"&&
sudo systemctl restart network