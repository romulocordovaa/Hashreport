#!/bin/bash

#VERSÃO 1.1

#Códigos ascii de cores usados
cor_azul='\033[0;34m'
cor_verde='\033[0;32m'
cor_vermelho='\033[0;31m'
cor_reset='\033[0m'

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

#Menu
#Lista de discos e partições
echo -e "${cor_azul}+==============================================================================+${cor_reset}";
lsblk -io KNAME,TYPE,MODEL,SERIAL,LABEL,FSTYPE,SIZE
echo -e "${cor_azul}+==============================================================================+${cor_reset}";

#Entrada de dados do usuário
printf "${cor_azul}[*]${cor_reset}Realizar hash em:\n"
printf "${cor_azul}[1]${cor_reset}Partições     ${cor_azul}[2]${cor_reset}Dispositivos\n"
read -p "$(echo -e $cor_azul">"$cor_reset)" escolha

printf "${cor_azul}[*]${cor_reset}Salvar informações em:\n"
# nomeArquivo= read -p "$(echo -e $cor_azul">"$cor_reset)"
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

#Processo de hash para partições
if [ $escolha -eq 1 ]
then
        printf "${cor_azul}[*]${cor_reset}Escolha as partições"
        read -p "$(echo -e $cor_azul">"$cor_reset)" particoes
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

                #Calcula
                hash=$(sudo sha512sum "$particao" 2>&1)
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
        printf "${cor_azul}[*]${cor_reset}Escolha os dispositivos\n"
#         dispositivos= read -p "$(echo -e $cor_azul">"$cor_reset)"
#         read -p "$(echo -e $cor_azul">"$cor_reset)" particoes
        read -p "$(echo -e $cor_azul">"$cor_reset)" dispositivos
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

                #Lista de hash a ser feito
                mapfile -t disks < <(sudo fdisk -l "$dispositivo" | awk '/^\/dev/ {print $1}')

                for h in ${disks[*]}
                    do
                        #Parte da escrita no arquivo
                        echo "== HASH=========================================" >> "$nomeArquivo"
                        echo "== $h" >> "$nomeArquivo"

                        #Marca o início do cálculo do hash
                        di=$(date '+%d/%m/%y %H:%M:%S')
                        inicio_processo=$(echo "Início: $di")

                        #Calcula o hash
                        hash=$(sudo sha512sum "$h" 2>&1)
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
paplay /usr/share/sounds/freedesktop/stereo/complete.oga
paplay /usr/share/sounds/freedesktop/stereo/complete.oga
paplay /usr/share/sounds/freedesktop/stereo/complete.oga
paplay /usr/share/sounds/freedesktop/stereo/complete.oga
