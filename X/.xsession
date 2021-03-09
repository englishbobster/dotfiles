#!/bin/bash

#xloadimage -onroot  -fullscreen ~/.fluxbox/Fantasy_Cthulhu_325644.jpg -global -center &
#set background
hsetroot

#set mouse cursor
xsetroot -cursor_name left_ptr

export PATH=$PATH:~/.xmonad/links

if [ -x /usr/bin/trayer-srg ]; then
    trayer-srg --edge top  --align right --SetDockType true --SetPartialStrut true --expand true --width 5 --transparent true --tint 0x191970 --height 12 &
elif [ -x /usr/bin/stalonetray ]; then
    stalonetray &
fi

if [ -x /usr/bin/nm-applet ] ; then
   nm-applet --sm-disable &
fi

if [ -x /usr/bin/pasystray ] ; then
   sleep 3
   pasystray &
elif [ -x /usr/bin/volumeicon ]; then
    volumeicon &
fi

if [ -x /usr/bin/xfce4-power-manager ] ; then
   sleep 3
   xfce4-power-manager &
fi

if [ -x /usr/bin/blueman-applet ] ; then
   sleep 3
   blueman-applet &
fi

if [ -x /usr/bin/xscreensaver ]; then
    sleep 3
    xscreensaver -no-splash &
fi

xrandr --output eDP-1-1 --mode 1920x1080 --pos 3840x0 --rotate normal \
	--output DP-1-1 --mode 1920x1080 --pos 1920x0 --rotate normal \
	--output DP-1-2 --mode 1920x1080 --pos 0x0 --rotate normal --primary \
	--output DP-1-3 --off \
	& xsetwacom --set "Wacom Co.,Ltd. Intuos BT S stylus" MapToOutput HEAD-0 \
	& xmonad

