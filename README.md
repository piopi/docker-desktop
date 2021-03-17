# Cypress Docker Desktop [![Docker Image CI](https://github.com/piopi/cypress-desktop/actions/workflows/docker-image.yml/badge.svg)](https://github.com/piopi/cypress-desktop/actions/workflows/docker-image.yml) ![](https://img.shields.io/docker/pulls/piopirahl/cypress-desktop-browsers.svg?maxAge=604800)

### Overview

A Dockerized light-weight desktop environment accessible from the brower with NoVNC. Google Chrome Browser included.

![](/screenshots/Capture.PNG)
*noVNC view of the Container running*

The Image comes with noVNC to allow user to view the desktop environment with their browsers.


### Usage

```
docker run -d -p 6901:6901 -p 5901:5901 piopirahl/cypress-desktop-base:cypress6.7.1
```



You will be able to access the noVNC windows at [http://localhost:6901](http://localhost:6901) or use your VNC viewer with `localhost:5901`

#### Ports

**6901** is exposed by default for the noVNC.

**5901** is exposed by default for VNC.

### DockerHub

DockerHub link of the images:

- https://hub.docker.com/repository/docker/piopirahl/cypress-desktop-base
- https://hub.docker.com/repository/docker/piopirahl/cypress-desktop-browsers

## Image Contents

- [Xvfb](http://www.x.org/releases/X11R7.6/doc/man/man1/Xvfb.1.xhtml) - X11 in a virtual framebuffer
- [TigerVNC](https://github.com/TigerVNC/tigervnc) - A VNC server that scrapes the above X11 server
- [noNVC](https://github.com/novnc/noVNC) - A HTML5 canvas vnc viewer
- [xfce4](https://www.xfce.org/) - a small desktop environment

## Maintainers

Mostapha El Sabah [Piopi](https://github.com/piopi)
