xrdb ~/.Xresources

source ~/.xprofile

[[ -f ~/.Xmodmap ]] && xmodmap ~/.Xmodmap 

export XMODIFIERS="@im=fcitx"
export LC_CTYPE=zh_CN.UTF-8

fcitx &

xrandr --dpi 121.29

xcape -e 'Hyper_L=Return;Hyper_R=Escape' &

xset r rate 200 30

compton -b --xrender-sync-fence
feh --bg-fill images/cat04.jpg

# xflux -l 39.0 -g 54.0

exec herbstluftwm --locked
