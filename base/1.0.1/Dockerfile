FROM debian:10.8-slim

ENV DISPLAY=:1 \
    VNC_PORT=5901 \
    NO_VNC_PORT=6901 \
    VNC_COL_DEPTH=32 \
    VNC_RESOLUTION=1920x1080

# No interactive frontend during docker build
ENV DEBIAN_FRONTEND=noninteractive



RUN apt-get update && \
  apt-get install --no-install-recommends -y \
  #install xvfb window environment
  xvfb xauth dbus-x11 xfce4 xfce4-terminal\
  #utilities packages
  wget curl gpg git bzip2 vim procps python x11-xserver-utils\
  #Chromium dependencies
  libnss3 libnspr4 libasound2 libgbm1 ca-certificates fonts-liberation libappindicator3-1 xdg-utils\
  # Chromium and tigervnc
  tigervnc-standalone-server tigervnc-common firefox-esr;\
  # Clean up
  apt-get clean; \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


ENV TERM xterm
# Install NOVNC.
RUN     git clone --branch v1.2.0 --single-branch https://github.com/novnc/noVNC.git /opt/noVNC; \
        git clone --branch v0.9.0 --single-branch https://github.com/novnc/websockify.git /opt/noVNC/utils/websockify; \
        ln -s /opt/noVNC/vnc.html /opt/noVNC/index.html

# disable shared memory X11 affecting Chromium
ENV QT_X11_NO_MITSHM=1 \
    _X11_NO_MITSHM=1 \
    _MITSHM=0


# give every user read write access to the "/root" folder where the binary is cached
RUN ls -la /root
RUN chmod 777 /root && mkdir /src

RUN groupadd -g 61000 docker; \
    useradd -g 61000 -l -m -s /bin/bash -u 61000 docker

COPY assets/config/ /home/docker/.config

RUN chown -R docker:docker /home/docker;\
    chmod -R 777 /home/docker ;

USER docker
# versions of local tools
RUN echo  "debian version:  $(cat /etc/debian_version) \n" \
          "user:            $(whoami) \n"

COPY scripts/entrypoint.sh /src

#Expose port 5901 to view display using VNC Viewer
EXPOSE 5901 6901
ENTRYPOINT ["/src/entrypoint.sh"]