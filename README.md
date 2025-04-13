---

Suricata + ELK Setup Guide

This project contains basic instructions to download and set up Suricata, Elasticsearch, and Kibana for network monitoring and analysis.

---

Downloads

Suricata

Download and install Suricata:

sudo apt update  
sudo apt install -y suricata
sudo suricata-update

Elasticsearch

Download and install Elasticsearch:

wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-8.11.1-amd64.deb  
sudo dpkg -i elasticsearch-8.11.1-amd64.deb

Start and enable the service:

sudo systemctl start elasticsearch  
sudo systemctl enable elasticsearch

Check if it’s running:

curl -X GET http://localhost:9200

---

Kibana

Download Kibana:

wget https://artifacts.elastic.co/downloads/kibana/kibana-8.11.1-amd64.deb  
sudo dpkg -i kibana-8.11.1-amd64.deb

Start and enable Kibana:

sudo systemctl start kibana  
sudo systemctl enable kibana

Once running, open http://localhost:5601 in your browser.

---

Integration with Suricata

To forward Suricata logs to Elasticsearch, enable EVE JSON logging in Suricata’s config:

(outputs section in /etc/suricata/suricata.yaml)

outputs:
  - eve-log:
      enabled: yes
      filetype: regular
      filename: /var/log/suricata/eve.json
      types:
        - alert
        - dns
        - http
        - tls

Use tools like Filebeat or Logstash to ship eve.json logs into Elasticsearch.

---

Notes

- Make sure all services (Suricata, Elasticsearch, Kibana) are compatible in terms of version.
- You may need to adjust system settings for performance, depending on your deployment.

---

Resources

Suricata Documentation: https://docs.suricata.io/  
Elastic Stack Docs: https://www.elastic.co/guide/index.html
