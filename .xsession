# Jeremy's .xsession 

# Set the background and root cursor shape (requires xsetroot)
# xsetroot -solid gray10
# xsetroot -cursor_name left_ptr


# Set up keymap to use Caps lock as Mod4 (windows) alternative
# xmodmap ~/MyDocs/.Xmodmap
# xmodmap -e "keycode 96 = Insert"

# from http://freemind.sourceforge.net/wiki/index.php/FreeMind_on_Linux, this fixes display issues with Freemind under Awesome.
# Also from https://wiki.archlinux.org/index.php/Dwm, sorts out problems with Arduino IDE in dwm.
wmname LG3D

xrandr --output HDMI-0 --rotate left --left-of DVI-I-1

feh --bg-scale  ~/Pictures/TylersLightPhoto.JPG

/home/jeremy/MyDocs/dwmstatus/dwmstatus &

xautolock -time 1 -locker /home/jeremy/git/slock/slock &

exec /home/jeremy/MyDocs/bin/StartDwm

