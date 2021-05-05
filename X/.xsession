#!/bin/bash

#xloadimage -onroot  -fullscreen ~/.fluxbox/Fantasy_Cthulhu_325644.jpg -global -center &
#set background
hsetroot

#set mouse cursor
xsetroot -cursor_name left_ptr
xrandr  --output DP-1  --mode 1920x1080 --pos 0x0 --rotate normal --primary \
	--output DP-2  --mode 1920x1080 --pos 1920x0 --rotate right \
       	--output eDP-1 --mode 1920x1080 --pos 3000x0 --rotate normal \
	--output DP-3 --off

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

xsetwacom --set "Wacom Co.,Ltd. Intuos BT S stylus" MapToOutput HEAD-0 \
& xmonad

