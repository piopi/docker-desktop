#!/bin/bash
# set -e: exit asap if a command exits with a non-zero status
set -e
trap ctrl_c INT
function ctrl_c() {
  exit 0
} 
# entrypoint.sh file for starting the xvfb with better screen resolution, configuring and running the vnc server.
rm /tmp/.X1-lock 2> /dev/null &
/opt/noVNC/utils/launch.sh --vnc localhost:$VNC_PORT --listen $NO_VNC_PORT &
vncserver $DISPLAY -depth $VNC_COL_DEPTH -geometry $VNC_RESOLUTION -SecurityTypes None &
wait