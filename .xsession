
xsetroot -solid "#222222"
xrdb -merge .Xdefaults

xmodmap -e "pointer = 1 25 3 4 5 6 7 8 9"

echo "Starting i3 $(date)"
exec /usr/bin/i3 

