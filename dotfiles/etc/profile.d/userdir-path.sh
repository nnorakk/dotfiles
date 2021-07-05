# Se o ID do usuário for maior ou igual a 1000 & se ~/bin existir e é um diretório e se ~/bin ainda não estiver no seu $PATH
# então exporta ~/bin para seu $PATH.
if [[ $UID -ge 1000 && -d $HOME/bin && -z $(echo $PATH | grep -o $HOME/bin) ]]
then
    export PATH="${PATH}:$HOME/bin:$HOME/.local/bin"
fi
