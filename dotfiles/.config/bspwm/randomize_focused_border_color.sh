#!/bin/bash
# adiciona a linha seguinte no crontab do usuario
# * * * * * DISPLAY=:0 $HOME/.config/bspwm/randomize_focused_border_color.sh
declare -a colors=(
 "#406ea5" 
 "#ff00ff" 
 "#8b008b" 
 "#ff00ff" 
 "#ffffff" 
 "#d6006e" 
 "#00ffff" 
 "#7fff00" 
 "#ffd700" 
 "#00ded1" 
 "#ffd700" 
 "#daa520" 
 "#ffd700" 
 "#7fffd4" 
 "#406ea5" 
 "#8b008b" 
 "#ff00ff" 
 "#d6006e" 
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
