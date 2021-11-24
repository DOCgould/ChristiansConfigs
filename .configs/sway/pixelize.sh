#!/bin/bash
 
# Dependencies:
# imagemagick
# swaylock
# grim
# corrupter (https://github.com/r00tman/corrupter)

#BLURTYPE="0x5" # 7.52s
#BLURTYPE="0x2" # 4.39s
#BLURTYPE="5x3" # 3.80s
BLURTYPE="2x8" # 2.90s
#BLURTYPE="2x3" # 2.92s
 
IMAGE=/tmp/i3lock.png
LOCK=~/stow/bin/assets/stop.png
LOCKARGS="--text-color=ffffff00 --inside-color=ffffff1c --ring-color=ffffff3e --line-color=ffffff00 --key-hl-color=00000080 --ring-ver-color=00000000 --inside-ver-color=0000001c --ring-wrong-color=00000055 --inside-wrong-color=0000001c"
for OUTPUT in `swaymsg -t get_outputs | jq -r '.[] | select(.active == true) | .name'`
do
    IMAGE=/tmp/$OUTPUT-lock.png
    grim -o $OUTPUT $IMAGE
    convert $IMAGE -scale 10% -scale 1000% -pointsize 20 -fill white -draw 'text 270,460 "Enter Password to Release Lock" ' $IMAGE
    LOCKARGS="${LOCKARGS} --image ${OUTPUT}:${IMAGE}"
    IMAGES="${IMAGES} ${IMAGE}"

done
swaylock $LOCKARGS
rm $IMAGES
