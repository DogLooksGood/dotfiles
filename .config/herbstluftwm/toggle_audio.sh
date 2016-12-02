#!/bin/bash

# Create directory if not exists.
if [ ! -d ~/.pulse ]; then
	mkdir ~/.pulse
fi

if [ -f ~/.pulse/mute ]; then
	echo 'Going to unmute'
	amixer set Master unmute;
	amixer set Speaker unmute;
	amixer set Headphone unmute;
	rm ~/.pulse/mute;
else
	echo 'Going to mute'
	amixer set Master mute;
	touch ~/.pulse/mute;
fi


