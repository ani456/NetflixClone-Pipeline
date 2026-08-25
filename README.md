# NetflixClone-Pipeline

-Create a vm (large) with 30+ gb of memory

-Install jenkins official docs step by step

-Install docker from official docs step by step

-add jenkins user to docker group and refresh with - newgrp docker

-create persistent volumes for sonarqube data, logs ,extensions.
docker volume inspect sonarqube_data
docker volume inspect sonarqube_extensions
docker volume inspect sonarqube_logs

-Install sonarqube (if you want to run sonarqube in docker):
docker run -d \
 --name sonarqube \
 --restart unless-stopped \ use this line if you want your container to start after vm reboot
-p 9000:9000 \
 -v sonarqube_data:/opt/sonarqube/data \
 -v sonarqube_extensions:/opt/sonarqube/extensions \
 -v sonarqube_logs:/opt/sonarqube/logs \
 sonarqube:lts-community

## Trivy installation

- sudo apt-get install wget gnupg
- wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | gpg --dearmor | sudo tee /usr/share/keyrings/trivy.gpg > /dev/null
  echo "deb [signed-by=/usr/share/keyrings/trivy.gpg] https://aquasecurity.github.io/trivy-repo/deb generic main" | sudo tee -a /etc/apt/sources.list.d/trivy.list

- sudo apt-get update
- sudo apt-get install trivy

## Install prometheus

create prometheus system user, as we don't want pormetheus running as root

-      sudo useradd --system --no-create-home --shell /bin/false prometheus
        ##On executing lib /bin/false the session immediately terminates i.e stops anyone to get an interactive shell
-      wget https://github.com/prometheus/prometheus/releases/download/v2.37.6/prometheus-2.37.6.linux-amd64.tar.gz

- tar xvfz prometheus-\*.tar.gz
- sudo mkdir /etc/prometheus /data
- cd prometheus-2.37.6.linux-amd64
- sudo mv prometheus promtool /usr/local/bin/
- sudo mv prometheus.yml /etc/prometheus/prometheus.yml
- sudo mv consoles/ console_libraries/ /etc/prometheus/
- sudo chown -R prometheus:prometheus /etc/prometheus /data

## Configure Prometheus as a Service(Systemd)

##Create a systemd service (so it runs as a proper daemon, survives reboot)

- [Unit]
  Description=Prometheus Monitoring System
  Wants=network-online.target
  After=network-online.target

[Service]
User=prometheus
Group=prometheus
Type=simple

ExecStart=/usr/local/bin/prometheus \
 --config.file=/etc/prometheus/prometheus.yml \
 --storage.tsdb.path=/data

Restart=on-failure

[Install]
WantedBy=multi-user.target

# View Prometheus logs with - journalctl -u prometheus -f --no-pager

## Installing Node Exporter

- Create a node exporter user
  sudo useradd --system --no-create-home --shell /bin/false node_exporter ##created system user with no home directory and shell access
