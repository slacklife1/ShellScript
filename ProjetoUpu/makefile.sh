#!/bin/bash

DIRETORIO="/opt/upu"    #VARIAVES GLOBAIS
UPU="upu.sh"
LINK="upu"



instalar () {		#FUNÇÃO DE INSTALAÇÃO
mkdir -p $DIRETORIO/bin

cp $UPU $DIRETORIO/bin
cp readme.txt $0 $DIRETORIO

ln -s $DIRETORIO/bin/$UPU /usr/bin/$LINK
}

remover () {		#FUNÇÃO DE REMOÇÃO

rm -R $DIRETORIO
rm /usr/bin/$LINK

}

main(){			#FUNÇÃO PRINCIPAL
	if [ $1 = "-R" ] || [ $1 = "-r" ]; then	#SE O PARAMENTRO FOR "-R" OU "-r" REMOVE TUDO
	       remover
        elif [ -z "$1" ]; then
 	       instalar
	else
 		echo "Paramentro invalido"
	fi
}	

main $1







