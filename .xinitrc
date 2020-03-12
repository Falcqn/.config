setxkbmap gb

## TODO: make this merge each file in .Xresources.d
[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

exec i3
