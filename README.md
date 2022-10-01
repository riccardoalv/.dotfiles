## Install
~~~bash
git clone "https://github.com/ricardo-cpu/.dotfiles"
./.dotfiles/install
~~~

## System
~~~
nixos-rebuild --use-remote-sudo --flake $HOME/.dotfiles#laptop switch --impure
~~~

## Home
~~~
home-manager --flake $HOME/.dotfiles switch
~~~
