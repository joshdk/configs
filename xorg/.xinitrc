# ~/.xinitrc
#
# Applies settings, and starts the window manager




#{{{ Xorg settings
if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# Remap launch button to mute
xmodmap -e "keycode 156 = XF86AudioMute NoSymbol XF86AudioMute"

# Disable tap-to-click on touchpad
synclient TapButton1=0

# Disable scroll coasting on touchpad
synclient CoastingSpeed=0

# Enable font directories
xset +fp /usr/share/fonts/local
xset +fp ~/.fonts
xset fp rehash

# Disable bell
xset -b
#}}}


#{{{ Volume settings
# Mute, and set volume to 20%
amixer set Master mute
amixer set Master 20%
#}}}


#{{{ Start window manager
SESSION="$1"

case "$SESSION" in
	awesome)
		# Awesome WM
		exec awesome &> ~/.config/awesome/awesome.log
		;;
	*)
		# Awesome WM
		exec awesome &> ~/.config/awesome/awesome.log
		;;
esac
#}}}
