#!/bin/bash

case $1 in
"cinema")
	dirnam="/home/aonis/cinema/garrysmod/"
	gamemode="cinema"
	map="teamvoc_nexmultiplex3"
	maxplayers=64
	port=27016
;;
"deathrun")
	dirnam="/home/aonis/obj/garrysmod/"
	gamemode="deathrun"
	map="deathrun_iceworld_v4"
	maxplayers=48
	port=27017
;;
"dev")
	dirnam="/home/aonis/beta/garrysmod/"
	gamemode="cinema"
	map="teamvoc_nexmultiplex3"
	maxplayers=2
	port=27025
;;
*)
	echo "ERROR! Incorrect Gamemode!"
esac

if [ -z $1 ]; then
	echo "To start server write 's <gamemode>'"
	echo "Gamemodes list: cinema, deathrun, dev"
else

	echo "Starting $1..."
	sleep 1
	cd $dirnam
	screen -A -h 2000 -m -d -S $1 ./srcds_run -game garrysmod +gamemode $gamemode +map $map +maxplayers $maxplayers +port $port +exec "server.cfg" -debug -disableluarefresh
	sleep 1
	screen -x $1
fi
