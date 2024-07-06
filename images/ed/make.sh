#!/bin/sh

imagemagick-string \
    -i ':ed' \
    -o foo.png \
    -bg None \
    -fg '#ff7700' \
    -fn 'Ubuntu-Mono-Bold' \
    -l 500 \
    -w 500 \
    -g 0.01 \
    -e '-stroke #ff7700 -strokewidth 7'
    #-ps 200
# imagemagick-trim foo.png
# imagemagick-shadow -i foo.png -o foo.png -sc Black

# imagemagick-shadow -i foo.png -o foo.png -sw 0 -sc none -bc black -bw 0.02 -sr 0
