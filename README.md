# msty-docker
This project is heavily based on the work of [linuxserver/obsidian](https://hub.docker.com/r/linuxserver/obsidian) which was used as a reference. For additional customizations, please refer to their project.

I had originally created this out of curiosity having examined how the Obsidian project was implementing Kasm, so I thought to try the same approach with Msty which currently does not have an official Docker release, but DOES have an official Linux release. I also managed to get persistent storage working for the application as well.

I'm not a seasoned Docker developer so any feedback or improvements to this would be appreciated. If anything, thank you for checking this out and if anything, hopefully it helps someone ^_^.

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
## Persistent Storage
Msty stores its database within the /tmp/ folder which if you destroy the container, you destroy the settings. To prevent this, I've mounted that directory within the config folder. If you want to remove persistence, just remove the second volume mount.