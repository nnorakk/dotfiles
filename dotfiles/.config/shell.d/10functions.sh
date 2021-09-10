# seta variaveis abaixo do arquivo ~/.dotenv
# export regular_user=
# export admin_user=
# export domain=
if [ -f ~/.dotenv ]; then
	. ~/.dotenv
fi

manvim() {
    nvim -c "set ft=man | Man $1" -c 'silent! only'
}

function rdesktop() {
/usr/bin/rdesktop -u ${regular_user} -d ${domain} $1 -z -P -x m
}
