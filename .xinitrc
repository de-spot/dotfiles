#!/bin/bash

#List all connected displays:
#xrandr | grep connected | grep -v disconnected | awk '{print }'

tryres() {
  local resol=$1
  echo "$resol" > ~/.xresolution
  xrandr -s $resol
  local rslt=$?
  if [[ $rslt -gt 0 ]]; then
    echo "Failed: $resol"
  fi
  return $rslt
}

xset -dpms # disable DPMS
xset s off # disable screensaver
xset s noblank # disable screen blank
if [ -x ~/.ssh-agent-ensure ]; then
  ~/.ssh-agent-ensure
  . ~/.ssh/agent.env
fi
# Resolution cascade will stop on error/failure
tryres "3840x2160" || tryres "4096x2160" || \
  tryres "2560x1600" || tryres "1920x1200" || tryres "1920x1080" || \
  tryres "800x600"
#xrandr --verbose > xrandr_verbose.txt
# Keyboard rate: delay repeat
xset r rate 300 80
# Remap keyboard
setxkbmap -option # clear all options
setxkbmap -model microsoft4000 -layout us,ru -option grp:caps_toggle
xmodmap .Xmodmaprc

#flatpak run org.mozilla.firefox &
#st &

# while true; do /usr/local/bin/dwm ; done
#exec ~/.local/bin/qtile start
#exec dbus-launch --exit-with-session /usr/local/bin/dwm ||
#exec dbus-launch --exit-with-session /usr/bin/gnome-session ||
exec dbus-launch --exit-with-session /usr/bin/gnome-session
#exec xfce4-session
