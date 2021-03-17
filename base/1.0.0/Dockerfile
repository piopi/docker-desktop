FROM debian:10.8-slim

ENV DISPLAY=:1 \
    VNC_PORT=5901 \
    NO_VNC_PORT=6901 \
    VNC_COL_DEPTH=32 \
    VNC_RESOLUTION=1920x1080 

# No interactive frontend during docker build
ENV DEBIAN_FRONTEND=noninteractive 

# "fake" dbus address to prevent errors
ENV DBUS_SESSION_BUS_ADDRESS=/dev/null


# good colors for most applications
ENV TERM vt100 


RUN apt-get update && \
  apt-get install --no-install-recommends -y \
  #install xvfb window environement
  xvfb xauth x11-utils tint2 dbus-x11 xfce4 xfce4-terminal\
  #utilities packages
  wget curl gpg git bzip2 vim procps python x11-xserver-utils\
  #FireFox and Chrome dependencies
  libnss3 libnspr4 libasound2 libgbm1 ca-certificates fonts-liberation libappindicator3-1 xdg-utils;\
  # Clean up
  apt-get clean; \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install NOVNC and TigerVNC.    
RUN     wget -qO- https://dl.bintray.com/tigervnc/stable/tigervnc-1.8.0.x86_64.tar.gz | tar xz --strip 1 -C /; \
        git clone --branch v1.2.0 --single-branch https://github.com/novnc/noVNC.git /opt/noVNC; \
        git clone --branch v0.9.0 --single-branch https://github.com/novnc/websockify.git /opt/noVNC/utils/websockify; \
        ln -s /opt/noVNC/vnc.html /opt/noVNC/index.html     
# disable shared memory X11 affecting  Chrome
ENV QT_X11_NO_MITSHM=1 \
    _X11_NO_MITSHM=1 \
    _MITSHM=0

# install Chrome browser
ENV CHROME_VERSION 89.0.4389.90
RUN wget -O /usr/src/google-chrome-stable_current_amd64.deb "http://dl.google.com/linux/chrome/deb/pool/main/g/google-chrome-stable/google-chrome-stable_${CHROME_VERSION}-1_amd64.deb" && \
  dpkg -i /usr/src/google-chrome-stable_current_amd64.deb; \
  apt-get install -f -y && \
  rm -f /usr/src/google-chrome-stable_current_amd64.deb; \
  apt-get clean; \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*; \
  google-chrome --version

# give every user read access to the "/root" folder where the binary is cached
RUN ls -la /root
RUN chmod 755 /root && mkdir /src
# versions of local tools
RUN echo  "npm version:     $(npm -v) \n" \
  "debian version:  $(cat /etc/debian_version) \n" \
  "Chrome version:  $(google-chrome --version) \n" \
  "user:            $(whoami) \n"
COPY scripts/entrypoint.sh /src
COPY assets/xfce4/.config /root/.config
#Expose port 5901 to view display using VNC Viewer
EXPOSE 5901 6901
ENTRYPOINT ["/src/entrypoint.sh"]