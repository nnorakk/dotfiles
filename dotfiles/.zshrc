# Carrega configuracoes extras alias, export, etc
for config in ${HOME}/.config/shell.d/*.sh; do
    source ${config}
done

source ${HOME}/.gemini_api_key.sh
