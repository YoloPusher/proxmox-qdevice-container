# Proxmox QDevice Container
This repository contains everything required to build and deploy a container which can serve as an [external QDevice](https://pve.proxmox.com/wiki/Cluster_Manager#_corosync_external_vote_support) for proxmox. This repository is inspired by [bcleonard/proxmox-qdevice](https://github.com/bcleonard/proxmox-qdevice) but contains following key changes and improvements:
- based on debian 13 (trixie)
- injects hash of root password instead of plaintext password
- added environment variable which triggers a script to disable root password login, as its only required during the inital setup
- runs corosync as coroqnetd user instead of root
- fixed qnetd initialization

## Setup
Following steps are required in order to deploy a QDevice container:
- add ip and interface configuration in [docker-compose.yml](docker-compose.yml)
- compute the sha512 hash of your desired root password: `openssl passwd -6 '<your_super_secure_password>'`
- add the hash of your root password into the [.env](.env) file

## Build & deploy
Build the image using docker build or your prefered build engine:
```bash
sudo docker build . -t proxmox-qdevice:0.1
```

Start the container (or paste it into portainer, keep in mind to add the environment variable when using portainer)
```bash
sudo docker compose up -d
```

After joining the cluster `DISABLE_PASSWORD_AUTH=true` can be uncommented in [docker-compose.yml](docker-compose.yml) in order to disable password login after restarting the container.

## Tested on following setup
Raspberry Pi 4 as QDevice running
- Debian 13.3 (trixie)
- Docker 29.1.5
- Docker Compose v5.0.1

Proxmox nodes running
- Proxmox VE 9.1.4
- corosync-qdevice 3.0.3
