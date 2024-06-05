sudo systemctl start firewalld
sudo firewall-cmd --remove-service=dhcpv6-client --permanent
sudo firewall-cmd --remove-service=cockpit --permanent
sudo firewall-cmd --remove-service=ssh --permanent
sudo firewall-cmd --add-port=22/tcp --permanent
sudo firewall-cmd --reload