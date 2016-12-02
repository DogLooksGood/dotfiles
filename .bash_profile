#
# ~/.bash_profile
#


[[ -f ~/.bashrc ]] && . ~/.bashrc

# Start X after login
if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
    startx
fi

export http_proxy = http://127.0.0.1:8118
