# Jeremy's .xsession 

# from http://freemind.sourceforge.net/wiki/index.php/FreeMind_on_Linux, this fixes display issues with Freemind under Awesome.
# Also from https://wiki.archlinux.org/index.php/Dwm, sorts out problems with Arduino IDE in dwm.
wmname LG3D

xrandr --output HDMI-0 --right-of DVI-0

feh --bg-scale  ~/Pictures/Background.jpg

/home/jeremy/dwm/dwmstatus-gold/dwmstatus &

setxkbmap -option ctrl:nocaps

exec /home/jeremy/config-gold/StartDwm

