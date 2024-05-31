#!/bin/sh

imagemagick-string -i ':ed' -o foo.png -bg None -fg White -fn 'Ubuntu-Mono' -x 200 -y 200
imagemagick-trim foo.png
imagemagick-shadow -i foo.png -o foo.png -sc White
