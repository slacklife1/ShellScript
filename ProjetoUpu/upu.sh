#!/bin/bash

#Versão 1.1.0


main () { 						#FUNCAO PRINCIPAL.. BUSCA PRIMEIRO ARQUIVO .gz POIS MENOR EXTENÇÃO
	
	if [ -z "$1" ]; then
	
		echo -e "Arquivo não enviado.\nUse:\n\tupu <NomeDoArquivo> -> Para Compactar\n\tupu <NomeDoArquivo.algo> -> Para Descompactar"
	
	else
		

		extencao=".gz"
		final=${#1}  					#RECEBE O NUMERO DE CARACTERES DA VARIAVEL $1 QUE O PRIMEIRO PARAMETRO 
		meio=$(expr $final - 3)  			#SUBTRAI DO NUMERO TOTAL DE CARACTERES 3.
		
		palavra=${1:$meio:3}                        #RETORNA OS 3 ULTIMOS CARACTERS DA STRING
	
							#CONDICIONAL PARA SABER SE O FINAL DA STRING É IGUAL .gz
			if [ $palavra = $extencao ]; then	#PODE SER USADO A EXPRESSAO test:->  if test "$palavra" = "$extencao"; then
				echo "Descompactando o arquivo $1"
				tar -vzxf $1
			else
				novaBusca $1			#CHAMA A NOVA BUSCA PASSANDO O PRIMEIRO PARAMETRO	
			fi

				

	fi	
}
novaBusca (){						#FUNCAO QUE BUSCA O RESTANTE DAS EXTENÇOES

	final=${#1}
	meio=$(expr $final - 4)

	palavra=${1:$meio:4}

		case $palavra in
			".rar")
				echo "Descompactando o arquivo $1"
				unrar x $1;;
			".zip")
				echo "Descompactando o arquivo $1"
				unzip $1;;
			".tar")
				echo "Descompactando o arquivo $1"
				tar -xvf $1;;
			".bz2")				
				extencao=".tar.bz2"
				meio=$(expr $meio - 4)
				
				palavra=${1:$meio:8}   #VAI BUSCAR DO CARATER DA POSICAO MEIO ATE 8 CARACTERES A FRENTE

					if [ $palavra = $extencao ]; then
						echo "Descompactando o arquivo $1"
						tar -jxvf $1

					else
						echo "Descompactando o arquivo $1"
						bzip2 -d $1
				
					fi ;;
						
			*)				#SE NAO ENCONTRAR ELE PERGUNTA SE QUE COMPACTAR
				compactar $1;;
		
			esac
			


}

compactar (){
	
	echo -e "Arquivo não encontrado na nossa base\n\nVoçê deseja compactar este arquivo em .zip $1?\n\n\t(Y) Sim\n\t(N) Não"
	printf "Informe a sua Opção:"	#OUTRA FORMA DE IMPRIMIR MA TELA
	read opcao
		
		if [ "$opcao" = "y" ] || [ "$opcao" = "Y" ] || [ -z "$opcao" ]; then #ACEITA O y Y eo ENTER
		
			echo "Compactando .zip"
			zip -r $1.zip $1

		else
			exit 0
		fi
}




main $1						#CHAMA A FUNCAO PRINCIPAL
		

