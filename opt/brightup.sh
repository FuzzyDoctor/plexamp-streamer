#!/bin/bash

brightness=$(head -n 1 /sys/class/backlight/rpi_backlight/brightness)
if [[ $brightness -lt 235 ]]; then
let brightness=$brightness+20
else
brightness=255
fi
echo $brightness > /sys/class/backlight/rpi_backlight/brightness
