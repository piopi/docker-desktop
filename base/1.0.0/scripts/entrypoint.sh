#!/bin/bash
# set -e: exit asap if a command exits with a non-zero status
set -e
# entrypoint.sh file for starting the xvfb with better screen resolution, configuring and running the vnc server.
rm /tmp/.X1-lock 2> /dev/null &
/opt/noVNC/utils/launch.sh --vnc localhost:$VNC_PORT --listen $NO_VNC_PORT &
vncserver $DISPLAY -depth $VNC_COL_DEPTH -geometry $VNC_RESOLUTION -SecurityTypes None &
echo "Waiting for VNC Display to be ready..."
while ! xdpyinfo -display ${DISPLAY}; do
  echo -n ''
  sleep 0.1
done
echo "Done waiting"
echo -e "start window manager\n..."&
xset -dpms &
xset s noblank &
xset s off &
dbus-launch xfce4-session & #Start the Window Manager
wait