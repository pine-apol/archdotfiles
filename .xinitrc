# Pipewire
exec /usr/bin/pipewire &
exec /usr/bin/pipewire-pulse &
exec /usr/bin/wireplumber &

# Compositor & Background
picom --config $HOME/.config/picom/picom.conf -b
~/.fehbg

# Suckless Stuff
slstatus &
exec dwm
