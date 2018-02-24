#!/bin/bash

#xloadimage -onroot  -fullscreen ~/.fluxbox/Fantasy_Cthulhu_325644.jpg -global -center &
#set background
hsetroot

#set mouse cursor
xsetroot -cursor_name left_ptr

export PATH=$PATH:~/.xmonad/links

trayer-srg --edge top  --align right --SetDockType true --SetPartialStrut true --expand true --width 5 --transparent true --tint 0x191970 --height 12 &

if [ -x /usr/bin/nm-applet ] ; then
   nm-applet --sm-disable &
fi

if [ -x /usr/bin/mate-volume-control-applet ] ; then
   sleep 3
   mate-volume-control-applet &
fi

if [ -x /usr/bin/mate-power-manager ] ; then
   sleep 3
   mate-power-manager &
fi

xmonad
