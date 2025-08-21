#!/bin/bash

brightness=$(head -n 1 /sys/class/backlight/rpi_backlight/brightness)
if [[ $brightness -gt 20 ]]; then
let brightness=$brightness-20
else
brightness=0
fi
echo $brightness > /sys/class/backlight/rpi_backlight/brightness
