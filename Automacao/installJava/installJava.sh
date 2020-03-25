#!/bin/bash

# Script de automação da instalação do Java
# Por Felipe Vieira <slacklife@gmail.com>
# Janeiro 2020

# Versão 1.0.0

#VARIAVEIS GLOBAIS

DIRETORIO="/opt/java"
PROFILE="/etc/profile"
CONT=("jdk" "linux")		       #DECLARAÇÃO DE UM VETOR DE STRING CONTROLE DE ARQUIVO


if [ -z "$1" ]; then			#VERIFICA SE O PARAMETRO E VAZIO
	echo "Parametro vazio"
else					#SE NÃO FOR VAZIO ELE INICIA A VERIFICAO SE REALMENTE É UM ARUIVO JDK

	var[0]=$(echo $1 | cut -f1 -d-) #RECEBE A PRIMEIRA PARTE DO PARAMETRO COM DELIMITADOR - jdk
	var[1]=$(echo $1 | cut -f3 -d-)	#RECEBE A TERCEIRA PARTE DO PARAMETRO COM DELIMITADOR - linux
	
	if [ "${var[0]}" = "${CONT[0]}" ] && [ "${var[1]}" = "${CONT[1]}" ]; then  
					#echo ${var[0]} FORMA COMO PRINTA UMA VARIAVEL VETOR
		echo "iniciando..."
	
		mkdir -p $DIRETORIO  		#CRIA DIRETORIO DE INSTALAÇÃO E CRIA O DIRETORIO DE BACKUP
		tar -vzxf $1 -C $DIRETORIO	#DESCOMPACTA NO DIRETORIO /OPT/JAVA
		local=$(ls $DIRETORIO)		#GUARDA O NOME DO DIRETORIO QUE O JAVA CRIOU
	

		echo "#INICIO VARIAVEL AMBIENTE JAVA">>$PROFILE  #INSERE /etc/profile AS VARIAVEIS DO JAVA
	   	echo "JAVA_HOME=$DIRETORIO/$local">>$PROFILE	
		echo "CLASSPATH=.:$""JAVA_HOME/lib/tools.jar">>$PROFILE	
		echo "PATH=$""JAVA_HOME/bin:$""PATH">>$PROFILE #TEM QUE SER DESSA FORMA, SENAO ELE NAO RECONHECE
		echo "export JAVA_HOME">>$PROFILE
		echo "export CLASSPATH">>$PROFILE		
		echo "export PATH">>$PROFILE
		echo "#FIM VARIALVEL JAVA">>$PROFILE

		source $PROFILE  	#ATUALIZA O TERMINAL
		java -version		#CONFIRMA SE FOI INSTALADO CORRETAMENTE

  	else
		echo "Arquivo jdk invalido"
		echo ${var[0]}
		echo ${var[1]}
		
 	 fi
	
fi





