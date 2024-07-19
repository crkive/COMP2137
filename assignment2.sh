#!/bin/bash


# Firewall Configuration
echo "SETTING UP THE FIREWALL CONFIGURATION NOW---------------------------------------------------------------------------------------------------------------------------------------"
sudo ufw enable
sudo ufw allow 22
sudo ufw allow 80
sudo ufw allow 3128


# Hosts File Update
echo "NOW WE WILL UPDATE /ETC/HOSTS-----------------------------------------------------------------------------------------------------------------------"
echo "192.168.16.21 server1" >> /etc/hosts

# Software Installation
echo "NOW WE WILL INSTALL APACHE2 and SQUID PACKAGES----------------------------------------------------------------------------------------------------------------------------"
sudo apt update
sudo apt install -y apache2 ufw squid



# Network Interface Configuration
echo "NOW WE WILL DO NETWORK CONFIGURATION---------------------------------------------------------------------------------------------------------------------------------"
sudo bash -c 'cat << EOF > /etc/netplan/01-netcfg.yaml
network:
  version: 2
  renderer: networkd
  ethernets:
    eth0:
      dhcp4: no
      addresses: [192.168.16.21/24]
      gateway4: 192.168.16.2
      nameservers:
        addresses: [192.168.16.2]
        search: [home.arpa, localdomain]
EOF'
sudo netplan apply



echo "WE HAVE SUCCESSFULLY COMPLETED ALL THE CONFIGURATIONS----------------------------------------------------------------------------------------------------------------------------------------"
