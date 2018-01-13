# dotfiles

This repo contains the dots from my latest install of Arch Linux. Deploy with [GNU/Stow](https://www.gnu.org/software/stow/). 
Most of my walls are sourced from [Unsplash](https://unsplash.com), and the colorscheme is all done by hand.

## scrot

### i3
![i3](https://track6.mixtape.moe/rvdyro.png)

### xfwm
![xfwm](https://0x0.st/sXau.png)

## info

- wm: `i3` (with gaps) and `xfwm`

- status bar: `polybar`

- text editor: `vim`

- terminal: `urxvt`

- shell: `zsh`

- launcher: `rofi`

- notification daemon: `dunst`

- compositor: `compton`

- music: `spotify`

## installation

install `stow` using your package manager

clone this repo  
`git clone https://github.com/icyphox/dotfiles icydots`

switch to the cloned directory  
`cd icydots`

use `stow -D <name of utility>` to _unstow_ the dotfiles into your `home` directory.


