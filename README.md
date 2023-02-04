# New Debian Setup

- Install with encrypted volume
- When you get to "tasksel", disable desktop and gnome, enable ssh and system only.
- Reboot and begin next steps

## Firmware 

By default my Intel chipset was not recognized. I get around this by disabling splash, adding non-free, and installing the firmware that Debian recommends.

- edit /etc/default/grub, uncomment console option (disable splash)
- update-grub

- add non-free to each /etc/apt/sources.list entry
- apt-get update
- apt-get install firmware-intel-sound firmware-linux firmware-iwlwifi (check spelling)

- apt-get remove lightdm

## Minimal X environment and console tools

- apt-get install xfce4 xfce4-power-manager tmux firefox-esr vlc git kpcli tree htop ncdu bc gnome-themes-extra-data nm-tray gawk cal

- now login as user and `startx`!

## XFCE Customizations

- edit /etc/default/keyboard
- set XKBOPTIONS="ctrl:nocaps"
- takes effect after reboot or /usr/sbin/setxkbmap -option "ctrl:nocaps"

- settings -> keyboard -> app shortcuts
- add -> xterm -> ctrl+shift+enter

- settings -> window manager -> title font -> 8pt
- keyboard tab -> show desktop -> window key (Super L)
- advanced tab -> wrap workspaces when reaching the screen edge: (1) yes with pointer (2) no with window.

## Browser Config

- open firefox, extensions, add: ublock, noscript, multi-account containers
- configure security settings for firefox

- firefox edit toolbar: remove pocket, add bookmarks button, disable title bar

## Dev Tools

- vscodium.com
- add apt repos
- install codium
- vim plugin
- beautify plugin

- install Docker from website - server edition
- follow post-install steps to add user to docker group, then reboot
- make a script in /usr/local/bin for docker-compose to run "docker compose $@"

- install lando via deb (not homebrew)
