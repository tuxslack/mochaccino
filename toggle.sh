#!/bin/bash

# Colaboração: Fernando Souza <www.youtube.com/@fernandosuporte>
# Data: 14/01/2025

clear

# Resumo:
# 
# Este script serve para alternar entre dois modos:
# 
#   Modo "Mochaccino Off": A tela pode entrar em modo de espera após um tempo de inatividade, e o tint2 é reiniciado com uma configuração padrão.
#   Modo "Mochaccino On":  A tela nunca entrará em modo de espera, e o tint2 é reiniciado com uma configuração específica (tint2rc-red).
# 
# A alternância entre esses modos é feita criando e removendo o arquivo mochaccino.enabled. Dependendo de sua existência, o comportamento da tela e da barra de tarefas será alterado.


# Verifica se os comandos tint2 e notify-send estão disponíveis no sistema. Caso algum desses comandos não seja encontrado, o script termina imediatamente.

which tint2         || exit
which notify-send   || exit


# Definições de variáveis:

# A variável tint_config define um arquivo de configuração específico para o tint2.
tint_config="tint2rc-red"

# Define o diretório onde o script está localizado.
SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

# Define o diretório de configurações do tint2.
TINT2FOLDER="$HOME/.config/tint2"


# Configura display para que possa ser executado fora do terminal
export DISPLAY=:0

# Verifica se o arquivo especificado existe e é um arquivo regular.

if [ -f $SCRIPTPATH/mochaccino.enabled ]; then

# Se o arquivo mochaccino.enabled existe:

#     Ele é removido (rm $SCRIPTPATH/mochaccino.enabled).
#     A mensagem "mochaccino off" é exibida via notify-send, indicando que a tela será desligada após um tempo de inatividade.
#     O comando xset +dpms reativa o gerenciamento de energia para a tela.
#     O processo tint2 é finalizado (killall tint2).
#     O tint2 é reiniciado com uma configuração padrão, tint2rc (barra de tarefas).
    

# Verifica se o arquivo especificado existe e é um arquivo regular.

 if [ -f $TINT2FOLDER/tint2rc ]; then
 
        # O arquivo existe.
    
	rm $SCRIPTPATH/mochaccino.enabled;
 
	notify-send -i $SCRIPTPATH/icone_vazio.png "mochaccino off" "A tela desligará em `xset q | grep Standby | awk '{print $2}'` segundos de inatividade";
 
	xset +dpms
 
	killall tint2
 
	tint2 -c $TINT2FOLDER/tint2rc &
    
else
        echo "O arquivo $TINT2FOLDER/tint2rc não existe."
fi

 
else


# Se o arquivo mochaccino.enabled não existe:

#     O arquivo mochaccino.enabled é criado (touch $SCRIPTPATH/mochaccino.enabled).
#     A mensagem "mochaccino on" é exibida via notify-send, indicando que a tela ficará ligada.
#     O comando xset -dpms desativa o gerenciamento de energia da tela, ou seja, a tela nunca entrará em modo de espera.
#     O processo tint2 é finalizado (killall tint2).
#     O tint2 é reiniciado com uma configuração específica ($tint_config).

# Verifica se o arquivo especificado existe e é um arquivo regular.

 if [ -f "$TINT2FOLDER/$tint_config" ]; then
 
        # O arquivo $TINT2FOLDER/$tint_config existe.

    	touch $SCRIPTPATH/mochaccino.enabled;
 
	notify-send -i $SCRIPTPATH/icone_cheio.png "mochaccino on" "A tela permanecerá ligada`dirname`";
 
	xset -dpms
 
	killall tint2
 
	tint2 -c $TINT2FOLDER/$tint_config &
 
else
        echo "O arquivo $TINT2FOLDER/$tint_config não existe."
fi   



fi


exit 0
