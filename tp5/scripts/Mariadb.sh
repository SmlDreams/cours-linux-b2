sudo dnf install -y mariadb-server
sudo systemctl start mariadb
sudo systemctl enable mariadb
sudo mysql < /path/to/init.mysql