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
xset r rate 300 80 # Keyboard rate: delay repeat

if [ -x ~/.ssh-agent-ensure ]; then
  ~/.ssh-agent-ensure
  . ~/.ssh/agent.env
fi

# Resolution cascade will stop on error/failure
tryres "3840x2160" || tryres "4096x2160" || \
  tryres "2560x1600" || tryres "1920x1200" || tryres "1920x1080" || \
  tryres "800x600"
#xrandr --verbose > xrandr_verbose.txt

# Remap keyboard
setxkbmap -option # clear all options
setxkbmap -model microsoft4000 -layout us,ru -option grp:caps_toggle
xmodmap .Xmodmaprc

#flatpak run org.mozilla.firefox &
#st &

#whiptail --title "Select DE" --menu "" 12 40 4 xfce XFCE3 gnom Gnome dwm DWM
# while true; do /usr/local/bin/dwm ; done
#exec ~/.local/bin/qtile start

if command -v xfce4-session; then
  exec dbus-launch --exit-with-session /usr/bin/xfce4-session
fi
if command -v gnome-session; then
  exec dbus-launch --exit-with-session /usr/bin/gnome-session
fi
if command -v dwm; then
  exec dbus-launch --exit-with-session /usr/local/bin/dwm
fi
  
