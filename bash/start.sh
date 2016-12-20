#!/bin/bash

case $1 in
"cinema")
        dirnam="$HOME/cinema/garrysmod"
        gamemode="cinema"
        map="teamvoc_nexmultiplex3"
        maxplayers=64
        port=27016
;;
"deathrun")
        dirnam="$HOME/obj/garrysmod"
        gamemode="deathrun"
        map="deathrun_iceworld_v4"
        maxplayers=48
        port=27017
;;
"dev")
        dirnam="$HOME/beta/garrysmod"
        gamemode="cinema"
        map="teamvoc_nexmultiplex3"
        maxplayers=32
        port=27025
;;
*)
        echo "ERROR! Incorrect Gamemode!"
esac

if [ -z $1 ]; then
        echo "To start server write 's <gamemode>'"
        echo "Gamemodes list: cinema, deathrun, dev"
        echo "To update server write 's <gamemode> update'"
else
        if [ -z $2 ]; then
                echo "Starting $1..."
                sleep 1
                cd $dirnam
                screen -A -h 2000 -m -d -S $1 ./srcds_run -game garrysmod +gamemode $gamemode +map $map +maxplayers $maxplayers +port $port +exec "server.cfg" -debug -disableluarefresh
                sleep 1
                screen -x $1
        else
                case $2 in
                "update")
                        echo "Checking updates for $1 server..."
                        ./bin/steamcmd.sh +login anonymous +force_install_dir $dirnam +app_update 4020 validate +quit
                ;;
                *)
                        echo "ERROR! Incorrect attribute!"
                        echo "To update server write 's <gamemode> update'"
                esac
        fi
fi
