#!/bin/bash

# Script de pos instalação do Debian de uso pessoal
# Por Felipe vieira <slacklife@gmail.com>
# Fevereiro 2020
# Versão 1.0

#VARIAVEIS GLOBAIS

DIRETORIO="pacotesPontoDeb"
DOCUMENTOS="doc"
ADICIONAR=$(cat $DOCUMENTOS/buscar.list)
REMOVER=$(cat $DOCUMENTOS/remover.list)


#gnome-keyring        ---> CORRIGE O ERRO MYSQLWORKBENTCH
#sqlmap, hydra, nikto ---> FERRAMENTA DE PENTEST
#net-toos	      ---> INSTALA O IFCONFIG


echo "EDITAR OS ARQUIVOS /etc/sudoers PARA TER ACESSO AO SUDO"

###################################################################
#COPIA UMA NOVA sources.list PARA O DIRETORIO /etc/apt/sources.list
#
cp $DOCUMENTOS/sources.list /etc/apt/sources.list

#################################################################################
# DOWNLOAD NECESSARIO PARA INSTALAÇÃO E ATUALIZAÇÃO DO VIRTUALBOX VIA REPOSITORIO

wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -

#####################
#REMOÇÃO DE PROGRAMAS 
#
apt-get remove --purge $REMOVER -y

###########################
#INSTALAÇAO DE PACOTES .deb
#
dpkg -i $DIRETORIO/*.deb
apt --fix-broken install

#########################
#ATUALIZACAO E INSTALAÇÃO
#
apt update -y
apt upgrade -y

apt-get install $ADICIONAR -y
updatedb
#########################
#DOWNLOAD E INSTALAÇÃO DO msfconsole e msfvenom
curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall && \
  chmod 755 msfinstall && \
  ./msfinstall

m-a prepare -y
apt autoremove -y
