#!/bin/bash

# Script de pos instalação do Debian de uso pessoal
# Por Felipe vieira <slacklife@gmail.com>
# Fevereiro 2020
# Versão 1.0

#VARIAVEIS GLOBAIS

#ADICIONAR AQUI OS PACOTES A SER INSTALADOS NA POSINSTALAÇÃO

PACOTES="nmap screenfetch build-essential module-assistant net-tools proxychains tor sqlmap hydra nikto"

apt update
apt upgrade

apt-get install $PACOTES
m-a prepare
apt autoremove
