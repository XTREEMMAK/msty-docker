# Msty-docker
This project is heavily based on the work of [linuxserver/obsidian](https://hub.docker.com/r/linuxserver/obsidian) which was used as a reference. For additional customizations, please refer to their project.

## About this Project
I originally created this out of curiosity after examining how the Obsidian project implemented [Kasm](https://kasmweb.com/). 
I thought I'd try the same approach with Msty, which currently doesn't have an official Docker release, but *DOES* have an official Linux release. I also managed to get persistent storage working for this application as well.

I'm not a seasoned Docker developer, so any feedback or improvements to this would be appreciated. Regardless, thank you for checking this out and hopefully, it helps someone ^_^.

## Usage
You can build the image yourself using the Dockerfile here, or use the Docker Compose:
```
---
services:
   msty:
    image: ghcr.io/xtreemmak/msty-docker:latest
    container_name: msty
    security_opt:
      - seccomp:unconfined #optional
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Etc/UTC
    volumes:
      - ./config:/config
      - ./config/msty-settings:/tmp/.config/Msty
    ports:
      - 3733:3000
      - 3734:3001
    devices:
      - /dev/dri:/dev/dri #optional
    shm_size: "1gb"
    restart: unless-stopped
```
Simply create a directory, create a compose file, and `sudo docker compose up -d`

## First Run
Please give it time to start. 
It takes a little time to pull the image from the repo so it may not show up immediately once you start the compose.

## Persistent Storage
Msty stores its database within the `/tmp/` folder which if you destroy the container, you destroy the settings. To prevent this, I've mounted that directory within the config folder. 
If you want to remove persistence, simply remove the second volume mount.

## Tips and Notice
- Please do NOT publish this to the public web unless you have something in front of it (such as [Authentik](https://goauthentik.io/)) for authentication and SSO.
- If you do build this yourself, make sure to download the startup.sh as well as it's needed.