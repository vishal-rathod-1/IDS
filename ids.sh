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

# Install tcpreplay
sudo apt install tcpreplay -y

# Download Elasticsearch, Kibana, Filebeat
cd ~/Downloads
wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-8.17.4-linux-x86_64.tar.gz
wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-8.17.4-linux-x86_64.tar.gz.sha512
shasum -a 512 -c elasticsearch-8.17.4-linux-x86_64.tar.gz.sha512
tar -xzf elasticsearch-8.17.4-linux-x86_64.tar.gz

curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-8.17.4-linux-x86_64.tar.gz
tar xzvf filebeat-8.17.4-linux-x86_64.tar.gz

curl -O https://artifacts.elastic.co/downloads/kibana/kibana-8.17.4-linux-x86_64.tar.gz
curl https://artifacts.elastic.co/downloads/kibana/kibana-8.17.4-linux-x86_64.tar.gz.sha512 | shasum -a 512 -c -
tar -xzf kibana-8.17.4-linux-x86_64.tar.gz

echo "Setup base complete. Please manually configure:"
echo "- /etc/network/interfaces"
echo "- filebeat.yml"
echo "- visudo for Zeek PATH"
echo "- cronjob for Zeek"
