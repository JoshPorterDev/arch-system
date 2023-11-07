~/.fehbg
setxkbmap -option "caps:ctrl_modifier" &
xrandr --output HDMI-1 --mode 1920x1080 --primary --output DP-3 --mode 1920x1080 --right-of HDMI-1 &
picom &
xset s off -dpms
exec bspwm
