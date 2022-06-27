# Carrega configuracoes extras alias, export, etc
for config in ${HOME}/.config/shell.d/*.sh; do
    source ${config}
done
