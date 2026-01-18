# Proxmox QDevice Container
This repository contains everything required to build and deploy a container which can serve as an [external qdevice](https://pve.proxmox.com/wiki/Cluster_Manager#_corosync_external_vote_support) for proxmox. This repository is inspired by [bcleonard/proxmox-qdevice](https://github.com/bcleonard/proxmox-qdevice) but contains following key changes and improvements:
- based on debian 13 (trixie)
- injects hash of root password instead of plaintext password
- runs corosync as coroqnetd user instead of root
- fixed qnetd initialization

## Setup
Following steps are required in order to deploy a qdevice container:
- add ip and interface configuration in [docker-compose.yml](docker-compose.yml)
- compute the sha512 hash of your desired root password: openssl passwd -6 '<your_super_secure_password>'
- add the hash of your root password into the [.env](.env) file

## Build & deploy
Build the image using docker build or your prefered build engine:
```bash
sudo docker build . -t proxmox-qdevice:0.1
```

Start the container (or paste it into portainer, keep in mind to add the env variable when using portainer)
```bash
sudo docker compose up -d
```
