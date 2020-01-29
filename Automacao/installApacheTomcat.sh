#!/bin/bash

# Script de automação da instalação do Java
# Por Felipe Vieira <slacklife@gmail.com>
# Janeiro 2020

# Versão 1.0.0

#VARIAVEIS GLOBAIS

DIRETORIO="/opt/tomcat"
PROFILE="/etc/profile"
CONT=("apache" "tomcat")		       #DECLARAÇÃO DE UM VETOR DE STRING CONTROLE DE ARQUIVO


if [ -z "$1" ]; then			#VERIFICA SE O PARAMETRO E VAZIO
	echo "Parametro vazio"
else					#SE NÃO FOR VAZIO ELE INICIA A VERIFICAO SE REALMENTE É UM ARUIVO JDK

	var[0]=$(echo $1 | cut -f1 -d-) #RECEBE A PRIMEIRA PARTE DO PARAMETRO COM DELIMITADOR - apache
	var[1]=$(echo $1 | cut -f2 -d-)	#RECEBE A TERCEIRA PARTE DO PARAMETRO COM DELIMITADOR - tomcat
	
	if [ "${var[0]}" = "${CONT[0]}" ] && [ "${var[1]}" = "${CONT[1]}" ]; then  
					#echo ${var[0]} FORMA COMO PRINTA UMA VARIAVEL VETOR
		echo "iniciando..."
	
		mkdir -p $DIRETORIO  		#CRIA DIRETORIO DE INSTALAÇÃO E CRIA O DIRETORIO DE BACKUP
		tar -vzxf $1 -C $DIRETORIO	#DESCOMPACTA NO DIRETORIO /OPT/JAVA
		local=$(ls $DIRETORIO)		#GUARDA O NOME DO DIRETORIO QUE O APACHE CRIOU
	

		echo "#INICIO VARIAVEL AMBIENTE APACHE">>$PROFILE  #INSERE /etc/profile AS VARIAVEIS DO TOMCAT
	   	echo "CATALINA_HOME=$DIRETORIO/$local">>$PROFILE
		echo "TOMCAT_HOME=$DIRETORIO/$local">>$PROFILE	
		echo "CLASSPATH=.">>$PROFILE
		echo "export CATALINA_HOME">>$PROFILE
		echo "export TOMCAT_HOME">>$PROFILE
		echo "export CLASSPATH">>$PROFILE		
		echo "#FIM VARIALVEL JAVA">>$PROFILE

		source $PROFILE  	#ATUALIZA O TERMINAL
	
  	else
		echo "Arquivo Apache Tomcat invalido"
		echo ${var[0]}
		echo ${var[1]}
		
 	 fi
	
fi





