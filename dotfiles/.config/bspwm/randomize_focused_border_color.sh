#!/bin/bash
# adiciona a linha seguinte no crontab do usuario
# * * * * * DISPLAY=:0 $HOME/.config/bspwm/randomize_focused_border_color.sh
declare -a colors=(
 "#00ded1" 
 "#00ffff" 
 "#406ea5" 
 "#7fff00" 
 "#7fffd4" 
 "#8b008b" 
 "#d6006e" 
 "#daa520" 
 "#ff00ff" 
 "#ffd700" 
)

# tamanho do array
len_colors=${#colors[@]}
# echo $len_colors

# randomize a cor escolhida
index=$(($RANDOM%$len_colors + 1))
echo $index

# seta cor da borda com foco ativo
bspc config focused_border_color ${colors[$index]} 
echo "Cor escolhida ${colors[$index]}"
