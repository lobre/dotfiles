# DOTFILES

Configuration files for linux

![Screenshot](https://github.com/lobre/dotfiles/raw/master/screenshot.png)

Shortcuts have been designed to be used with a Bépo keyboard layout. Here are the tools included.

 - i3wm
 - tmux
 - vim
 - less
 - sublime text
 - ranger
 - zshrc

Graphical and terminal application configurations are split in two different folders.

## Install script

    # with gui bindings
    make link
    
    # only terminal binding
    make term-link

## Docker

A Dockerfile is implemented to build an environment with only terminal based applications.

    # build
    make docker

    # run
    docker run --rm -ti --name dotfiles -e TERM=$TERM -v $(pwd):/home/dev/Lab lobre/dotfiles

## Generate ISO

There is a script to generate an ISO bootable version with Ubuntu 18.04 desktop, all software
pre-baked and with configurations already set up. It runs from withing a Docker container.

In order to be able to launch it, you need to fit the requirements:
 - make sure to have at least 10gb available on disk (`/var` partition)
 - you should be running it from an Ubuntu 18 system (same as the one being generated)

It can take up to half an hour to generate. You can them burn this ISO onto a bootable
USB key or use it with a virtualization software.

    make iso

## Burn ISO on USB

`ddrescue` can be used to create a live USB version of the ISO.

    sudo ddrescue lobre.iso /dev/sdX --force -D

## Shortcut reference table

Shortcuts tend to be consistent between apps. Here is a table listing a few of them.

|                            | Home                            | Ctrl-W                         | Ctrl-Space                     |
| -------------------------- | ------------------------------- | ------------------------------ | ------------------------------ |
| c/t/s/r                    | [i3] switch containers          | [vim] switch panes             | [tmux] switch panes            |
| n/p                        | [i3] next/previous workspace    | [vim] next/previous buffer     | [tmux] next/previous window    |
| q                          | [i3] close window               | [vim] close window             | [tmux] close pane              |
| g                          | [i3] rofi window switcher       |                                | [tmux] copy mode               |
| /-                         | [i3] split orientation          | [vim] split window             | [tmux] split pane              |
| z                          | [i3] full screen                |                                | [tmux] zoom pane               |
|                            |                                 |                                |                                |

## Colors

Colors are generated from a base 16 template. See `.Xresources` to check colors. These colors are propagated from X resources to other apps.

 - Uxrvt
 - Rofi
 - i3
 - Polybar
 - Dunst

Colors can be easily visualized using https://terminal.sexy.

## Icons

A pached font from [nerdfonts](https://nerdfonts.com) is used. It contains a large list of icons. In order to copy them into configuration files, the tool `gucharmap` can be handy.

## Visual Studio Code

The configuration of `vscode` is saved in this repo but the list of extensions does not save automatically. Here is the command to update the list of extensions.

    code --list-extensions | xargs -L 1 echo code --install-extension >| graphical/.config/Code/extensions.sh

This script can then be used to restore and install extensions.
