#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
TINT2FOLDER="/home/filipe/.config/tint2"

# Configura display para que possa ser executado fora do terminal
export DISPLAY=:0

if [ -f $SCRIPTPATH/mochaccino.enabled ]; then
	rm $SCRIPTPATH/mochaccino.enabled;
	notify-send -i $SCRIPTPATH/icone_vazio.png "mochaccino off" "A tela desligará em `xset q | grep Standby | awk '{print $2}'` segundos de inatividade";
	xset +dpms
	killall tint2
	tint2 -c $TINT2FOLDER/tint2rc &
else
	touch $SCRIPTPATH/mochaccino.enabled;
	notify-send -i $SCRIPTPATH/icone_cheio.png "mochaccino on" "A tela permanecerá ligada`dirname`";
	xset -dpms
	killall tint2
	tint2 -c $TINT2FOLDER/tint2rc-red &
fi
