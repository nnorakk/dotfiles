#!/bin/sh
# Inspirado em:
# https://gitlab.dwbn.org/TobiasSteinhoff/dotfiles-ansible.git
# https://github.com/wincent/wincent

# Determina sistema operacional
HOST_OS=$(uname -s)

# Obtem credenciais de superusuario para instalar apps
sudo -v 

case "$HOST_OS" in
    Darwin)
        echo "Macos"

        if $(hash gcc 2> /dev/null); then
            echo "Command Line Tools instalada"
        else
            echo "Instale Command Line Tools..."
            xcode-select --install
        fi

        if $(hash brew 2> /dev/null); then
            echo "brew ja instalado"
        else
            echo "Instale brew..."
            /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
        fi

        if $(hash ansible-playbook 2> /dev/null); then
            echo "ansible ja instalado"
        else
            echo "Instale ansible..."
            brew install ansible
        fi
        ;;
    Linux)
        echo "Linux"

        sudo dnf update -y 

        if $(hash ansible-playbook 2> /dev/null); then
            echo "ansible ja instalado"
        else
            echo "Instale ansible..."
            sudo dnf install -y ansible
        fi
        ;;
esac

ansible-playbook -K deploy${HOST_OS}.yml 
