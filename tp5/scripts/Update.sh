sudo dnf update -y
sudo setenforce 0
sudo sed -i 's/SELinux=enforcing/SELinux=permissive/' /etc/selinux/config