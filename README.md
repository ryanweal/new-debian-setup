# New Debian Setup

- Install with encrypted volume
- When you get to "tasksel", disable desktop and gnome, enable ssh and system only.
- Reboot and begin next steps

- apt-get install xfce4 xfce4-power-manager tmux firefox-esr vlc git kpcli tree htop ncdu bc gnome-themes-extra-data nm-tray

- edit /etc/default/grub, uncomment console option (disable splash)
- update-grub

- add non-free to each /etc/apt/sources.list entry
- apt-get update
- apt-get install firmware-intel-sound firmware-linux firmware-iwlwifi (check spelling)

- apt-get remove lightdm

- now login as user and `startx`!

- edit `/etc/default/keyboard`
- set XKBOPTIONS="ctrl:nocaps"
- takes effect after reboot or /usr/sbin/setxkbmap -option "ctrl:nocaps"

# Install Essential Tools

- open firefox, extensions, add: ublock, noscript, multi-account containers
- configure security settings for firefox

- vscodium.com
- add apt repos
- install codium

- install Docker from website - server edition
- follow post-install steps to add user to docker group, then reboot
- make a script in /usr/local/bin for docker-compose to run "docker compose $@"

- firefox edit toolbar: remove pocket, add bookmarks button, disable title bar

- firefox: disable blacklist sending queries to google
- firefox:  disable dns-over-https - often causes errors on first hit of non-democrat sites via Starlink

# Mouse overrides: set speed of trackpoint on Lenovo USB Keyboard

First, see what device you want to override: `xinput`

Then, optionally using "pointer:" prefix (if multi-function), list out what options are available.

`xinput list-props "pointer:Lenovo ThinkPad Compact USB Keyboard with TrackPoint"`

Here is the one I was looking for:

        libinput Accel Speed (323):     0.800000

Now I had tried to configure this with udev but it did not work. The best way seems to be with an X11 config:

NOTE 2 things: MatchProduct aligns with our name. And AccelSpeed is our above value. Not sure what all the other stuff is doing at the moment.

Section "InputClass"
    Identifier  "Trackpoint Wheel Emulation"
    MatchProduct        "Lenovo ThinkPad Compact USB Keyboard with TrackPoint"
    MatchDevicePath     "/dev/input/event*"
    Option              "XAxisMapping"          "6 7"
    Option              "YAxisMapping"          "4 5"
    Option              "AccelSpeed"            ".8"
    Option         "EmulateWheel" "true"
    Option         "EmulateWheelButton" "2"
    Option         "EmulateWheelTimeout" "100"
    Option         "Emulate3Buttons" "true"
EndSection


# Mouse overrides - Prevent middle-click on scroll-finished

See https://github.com/lentinj/tp-compact-keyboard/issues/23

Creating a blacklisted module did not work.

-  /etc/modprobe.d/custom-blacklist.conf 
- blacklist hid_lenovo

My udev rule never worked either even just for setting the speed... probably did not match or X11 config overruled it.

/etc/udev/rules.d/10-trackpoint.rules

ACTION=="add", SUBSYSTEM="hid", DRIVERS="lenovo", ATTR{sensitivity}="1"
ACTION=="add", SUBSYSTEM="hid", DRIVERS="lenovo", ATTR{device/libinput Accel Speed}="1"
ACTION=="add", SUBSYSTEM=="input", ATTR{name}=="pointer:Lenovo ThinkPad Compact USB Keyboard with TrackPoint", ATTR{device/libinput Accel Speed}=".9"

The best solution was to use X11 config to set the speed, and use .xsession to disable middle-click which was pasting after scroll-finsihed:

# .xsession

xsetroot -solid "#222222"
xrdb -merge .Xdefaults

xmodmap -e "pointer = 1 25 3 4 5 6 7 8 9"

echo "Starting i3 $(date)"
exec /usr/bin/i3 

# .Xdefaults - beautiful xterm with paste

See the provided .Xdefaults in this repo

# .vimrc - allow xterm paste

Needed a .vimrc to overridem /usr/share/vim/.../debian.vim)

`syntax on` was the only value from debian.vim that mattered

# More middle button options to explore?

I did not end up using these but I was surprised to learn...

- vscode override: "editor.selectionClipboard": false,

- firefox override: go to about:config and set: `#middlemouse.contentLoadURL false` and `#middlemouse.paste false`

# Setting the default folders

~.config/user-dirs.dirs

XDG_DESKTOP_DIR="$HOME"
XDG_DOWNLOAD_DIR="$HOME/downloads"
XDG_TEMPLATES_DIR="$HOME/media/books"
XDG_PUBLICSHARE_DIR="$HOME"
XDG_DOCUMENTS_DIR="$HOME/clients"
XDG_MUSIC_DIR="$HOME/media/music"
XDG_PICTURES_DIR="$HOME/media/photos"
XDG_VIDEOS_DIR="$HOME/media/videos"

