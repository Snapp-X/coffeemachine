#!/bin/bash

#Retrieving the current display width and height
resolution=$(xrandr --current | awk '/\*/ { print $1 }')
IFS='x' read -ra dimensions <<< "$resolution"
width=${dimensions[0]}
height=${dimensions[1]}

#echo "Width: $width"
#echo "Height: $height"

current_folder=$(basename "$(pwd)")
weston --shell=kiosk-shell.so --width="$width" --height="$height" -f &

sleep 1
./build/elinux/arm64/release/bundle/"$current_folder" --bundle=. &
#sleep 1
xdotool mousemove 0 0 &

