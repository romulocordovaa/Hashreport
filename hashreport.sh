#!/bin/bash

#VERSÃO 1.1

#Códigos ascii de cores usadas
cor_azul='\033[0;34m'
cor_verde='\033[0;32m'
cor_vermelho='\033[0;31m'
cor_reset='\033[0m'
cor_amarelo='\033[0;33m'

#Parâmetros posicionais
for parametro in ${@};
    do
        #Manual
        if [ ${parametro} == "-h" ] || [ ${parametro} == "--help" ]
            then
                printf "\n${cor_azul}Opções gerais:${cor_reset}\n"
                echo "    -h,--help         Mostra o manual"
                echo "    -v,--version      Mostra a versão do Hashreport"
                printf "${cor_verde}Para mais informações acesse a página do github:${cor_reset} https://github.com/romulocordovaa/Hashreport\n"
                exit
            fi
        if [ ${parametro} == "-v" ] || [ ${parametro} == "--version" ]
            then
                echo "Hashreport V1.1"
            fi
    done

echo -e "${cor_azul}+==============================================================================+${cor_reset}";
lsblk -io KNAME,TYPE,MODEL,SERIAL,LABEL,FSTYPE,SIZE
echo -e "${cor_azul}+==============================================================================+${cor_reset}";

#Entrada de dados do usuário
printf "${cor_azul}[*]${cor_reset}Realizar hash em:\n"
printf "${cor_azul}[1]${cor_reset}Partições     ${cor_azul}[2]${cor_reset}Dispositivos\n"
read -p "$(echo -e $cor_azul">"$cor_reset)" escolha

printf "${cor_azul}[*]${cor_reset}Tipo da hash:\n"
printf "${cor_azul}[1]${cor_reset}MD5     ${cor_azul}[2]${cor_reset}SHA512\n"
read -p "$(echo -e $cor_azul">"$cor_reset)" tipo_hash

printf "${cor_azul}[*]${cor_reset}Salvar informações em:\n"
read -p "$(echo -e $cor_azul">"$cor_reset)" nomeArquivo

#Verificação de arquivos já existente
if [ -f "$nomeArquivo" ];
        then
            printf "${cor_vermelho}[!]${cor_reset}Arquivo já existe. Deseja susbtituir?[S/N]\n"
            read -p "$(echo -e $cor_azul">"$cor_reset)" res
            res=${res,,};
            if [ "$res" == "s" ] || [ "$res" == "S" ];
                then
                    rm "$nomeArquivo";
                else
                    exit;
                fi
        fi

#Processo de hash para a opção de partições
if [ $escolha -eq 1 ]
then
        printf "${cor_azul}[*]${cor_reset}Escolha as partições\n"
        read -p "$(echo -e $cor_azul">"$cor_reset)" particoes
        printf "${cor_amarelo}PROCESSANDO...${cor_reset}\n"

        printf "#HASHREPORT V1.1" >> "$nomeArquivo"
        echo " " >> "$nomeArquivo"
        for particao in ${particoes[*]}
            do
                #Parte da escrita no arquivo
                lsblk -io KNAME,TYPE,MODEL,SERIAL,LABEL,FSTYPE,SIZE $particao >> "$nomeArquivo"
                echo "== DISPOSITIVO: $particao" >> "$nomeArquivo"

                echo "== HASH=========================================" >> "$nomeArquivo"
                echo "== $particao" >> "$nomeArquivo"

                #Marca o início do cálculo do hash
                di=$(date '+%b/%m/%y %H:%M:%S')
                inicio_processo=$(echo "Início: $di")

                #Calculo do hash sha512 ou md5
                if [ $tipo_hash == "1" ]
                    then
                        hash=$(sudo md5sum "$particao" 2>&1)
                    else
                        hash=$(sudo sha512sum "$particao" 2>&1)
                fi

                if [ $? -eq 1 ]
                    then
                        echo $hash >> "$nomeArquivo"
                    else
                        echo "Hash: $hash" >> "$nomeArquivo"
                fi
                echo "%$hash"

                #Marca o final do cálculo do hash
                df=$(date '+%b/%m/%y %H:%M:%S');
                final_processo=$(echo "Término: $df")


                echo $inicio_processo >> "$nomeArquivo"
                echo $final_processo >> "$nomeArquivo"

                echo " " >> "$nomeArquivo"
            done

else
        #processo de hash para a opção de dispositivos
        printf "${cor_azul}[*]${cor_reset}Escolha os dispositivos\n"
        read -p "$(echo -e $cor_azul">"$cor_reset)" dispositivos
        printf "${cor_amarelo}PROCESSANDO...${cor_reset}\n"

        printf "#HASHREPORT V1.1\n" >> "$nomeArquivo"
        for dispositivo in ${dispositivos[*]};
            do
                #Lista de dispositivos
                dispo=$(lsblk -io KNAME,TYPE,MODEL,SERIAL,LABEL,FSTYPE,SIZE "$dispositivo")
                declare -a dispo_list=(${dispo})

                #Parte da escrita no arquivo
                echo "== DISPOSITIVO: $dispositivo" >> "$nomeArquivo"
                echo "================================================" >> "$nomeArquivo"
                printf " \n$dispo" >> "$nomeArquivo"
                echo " " >> "$nomeArquivo"
                #Lista de partições para realizar o hash
                mapfile -t disks < <(sudo fdisk -l "$dispositivo" | awk '/^\/dev/ {print $1}')

                for h in ${disks[*]}
                    do
                        #Parte da escrita no arquivo
                        echo "== HASH=========================================" >> "$nomeArquivo"
                        echo "== $h" >> "$nomeArquivo"

                        #Marca o início do cálculo do hash
                        di=$(date '+%d/%m/%y %H:%M:%S')
                        inicio_processo=$(echo "Início: $di")

                        #Calculo do hash sha512 ou md5
                        if [ $tipo_hash == "1" ]
                            then
                                hash=$(sudo md5sum "$h" 2>&1)
                            else
                                hash=$(sudo sha512sum "$h" 2>&1)
                        fi

                        if [ $? -eq 1 ]
                        then
                            echo "" >> "$nomeArquivo"
                        else
                            echo "Hash: $hash" >> "$nomeArquivo"
                        fi

                        #Marca o final do cálculo do hash
                        df=$(date '+%d/%m/%y %H:%M:%S')
                        final_processo=$(echo "Término: $df")

                        echo $inicio_processo >> "$nomeArquivo"
                        echo $final_processo >> "$nomeArquivo"

                        echo " " >> "$nomeArquivo"
                    done
            done
fi

#Alerta sonoro
contador=0
  while true
    do
        tput bel
        sleep 0.2
        contador=$(($contador+1))

    if [ $contador -gt 20 ]; then
    break
    exit 1
  fi
  done
printf "${cor_verde}FINALIZADO${cor_reset}\n"
