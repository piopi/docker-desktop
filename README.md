# Docker Desktop [![Docker Image CI](https://github.com/piopi/cypress-desktop/actions/workflows/docker-image.yml/badge.svg)](https://github.com/piopi/cypress-desktop/actions/workflows/docker-image.yml) ![](https://img.shields.io/docker/pulls/piopirahl/docker-desktop.svg?maxAge=60480)

## Overview

A Dockerized light-weight desktop environment accessible from the browser with NoVNC. Firefox Browser included.

![](/screenshots/Capture.PNG)
*noVNC view of the Container running*

The Image comes with noVNC to allow user to view the desktop environment with their browsers.

## Usage

```Shell
docker run -d -p 6901:6901 -p 5901:5901 --name desktop piopirahl/docker-desktop:1.0.2
```

You will be able to access the noVNC windows at [http://localhost:6901](http://localhost:6901) or use your VNC viewer with `localhost:5901`

### Custom configs

The config files are stored under `/home/dockeruser/.config` on the container.
In order, to save on your host your configs, you can follow those steps:

1. Run the docker image to generate the configs on the container

```Shell
docker run -d -p 6901:6901 -p 5901:5901 --name desktop piopirahl/docker-desktop:1.0.2
```

2. Copy the content of the container on the host

```Shell
mkdir config
docker cp desktop:/home/dockeruser/.config  $PWD/config
```

3. Stop the running container and start a new one with a mounted volume

```Shell
docker rm -f desktop
docker run -d -p 6901:6901 -p 5901:5901 --name desktop -v $PWD/config/.config:/home/dockeruser/.config piopirahl/docker-desktop:1.0.2
```

4. Now your local configs will be saved on your host machine

### Ports

**6901** is exposed by default for the noVNC.

**5901** is exposed by default for VNC.

## DockerHub

DockerHub link of the images:

- [https://hub.docker.com/repository/docker/piopirahl/docker-desktop](https://hub.docker.com/repository/docker/piopirahl/docker-desktop)

## Image Contents

- [Xvfb](http://www.x.org/releases/X11R7.6/doc/man/man1/Xvfb.1.xhtml) - X11 in a virtual framebuffer
- [TigerVNC](https://github.com/TigerVNC/tigervnc) - A VNC server that scrapes the above X11 server
- [noNVC](https://github.com/novnc/noVNC) - A HTML5 canvas vnc viewer
- [xfce4](https://www.xfce.org/) - a small desktop environment

## Maintainers

Mostapha El Sabah [Piopi](https://github.com/piopi)
