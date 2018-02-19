# Jeremy's .xsession 

# from http://freemind.sourceforge.net/wiki/index.php/FreeMind_on_Linux, this fixes display issues with Freemind under Awesome.
# Also from https://wiki.archlinux.org/index.php/Dwm, sorts out problems with Arduino IDE in dwm.
wmname LG3D

xrandr --output HDMI-0 --rotate left --left-of DVI-I-1

feh --bg-scale  ~/Pictures/TylersLightPhoto.JPG

/home/jeremy/dwm/dwmstatus-gold/dwmstatus &

# xautolock -time 1 -locker /home/jeremy/git/slock/slock &

xmodmap /home/jeremy/.Xmodmap

exec /home/jeremy/config-gold/StartDwm

