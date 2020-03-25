#!/bin/bash

# Script de pos instalação do Debian de uso pessoal
# Por Felipe vieira <slacklife@gmail.com>
# Fevereiro 2020
# Versão 1.0

#VARIAVEIS GLOBAIS

DIRETORIO="pacotes.deb"

ADICIONAR="vim mysql-client nmap screenfetch build-essential module-assistant net-tools proxychains tor sqlmap hydra gnome-keyring"
REMOVER="mariadb*"


#gnome-keyring        ---> CORRIGE O ERRO MYSQLWORKBENTCH
#sqlmap, hydra, nikto ---> FERRAMENTA DE PENTEST
#net-toos	      ---> INSTALA O IFCONFIG


echo "EDITAR OS ARQUIVOS /etc/sudoers e /etc/apt/source.list"


apt-get remove --purge $REMOVER -y

dpkg -i $DIRETORIO
apt --fix-broken install

apt update -y
apt upgrade -y
apt-get install $ADICIONAR -y
m-a prepare -y
apt autoremove -y
