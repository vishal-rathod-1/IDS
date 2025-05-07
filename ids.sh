#!/bin/bash

# Update system
sudo apt update && sudo apt upgrade -y
sudo apt install ifupdown net-tools git cmake make gcc g++ flex bison libpcap-dev python3-dev swig zlib1g-dev curl -y

# Disable netplan
sudo service systemd-networkd stop
sudo apt remove netplan -y

# Install Suricata
sudo apt install suricata -y
sudo suricata-update

# Setup Zeek Repo
echo 'deb http://download.opensuse.org/repositories/security:/zeek/xUbuntu_22.04/ /' | sudo tee /etc/apt/sources.list.d/security:zeek.list
curl -fsSL https://download.opensuse.org/repositories/security:zeek/xUbuntu_22.04/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/security_zeek.gpg > /dev/null
sudo apt update
sudo apt install zeek-6.0 -y

#Install suricata
sudo apt install suricata -y

#install kibana
sudo apt install kibana -y

#install filebeat
sudo apt install filebeat -y

#install elastic search

sudo apt install elasticsearch -y

# Install tcpreplay
sudo apt install tcpreplay -y

#Update this 
echo "Setup base complete. Please manually configure:"
echo "- /etc/network/interfaces"
echo "- filebeat.yml"
echo "- visudo for Zeek PATH"
echo "- cronjob for Zeek"
