# Carrega configuracoes extras alias, export, etc
for config in ${HOME}/.config/shell.d/*; do
    source ${config}
done
