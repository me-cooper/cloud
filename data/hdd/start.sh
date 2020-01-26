#!/bin/bash

#Shell leeren
clear

#Projektnamen aus Datei data/_temp/name auslesen
name=$(cat cloud/data/_temp/name)

#Webverzeichnis-Pfad generieren
web_folder="$name"

#Datenverzeichnis-Pfad generieren
mount_folder="$name""_files"


#Frage
HEIGHT=15
WIDTH=70
CHOICE_HEIGHT=3
BACKTITLE="Externe Festplatte"
TITLE="Externe Festplatte"
MENU="\nHast du zufällig eine externe Festplatte?\nSollte leer sein: wird formatiert"

OPTIONS=(1 "Ja"
         2 "Nein")

CHOICE=$(dialog --clear \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)

clear
case $CHOICE in
        1)
            #Auswahl >steckt schon<
            clear
            #Nachricht
            printf "\n\nGute Entscheidung!\n\n\n"

            function coutdown(){
              zahl="5"
              step="1"
               while [ "$zahl" != 0 ]; do
                 figlet "$zahl"
                 ((zahl-=1))
                 sleep 1
               done
            }

            function coutdown_silent(){
              zahl="7"
              step="1"
               while [ "$zahl" != 0 ]; do
                 ((zahl-=1))
                 sleep 1
               done
            }

            printf "Stelle sicher, dass KEIN anderes Gerät als deine Festplatte angeschlossen ist.\nALLE Daten auf den Datenträgern werden jetzt gelöscht.\n\n"
            coutdown_silent
            read -p ">>BESTÄTIGEN<<"

            clear

            coutdown

            sudo bash cloud/data/hdd/hdd.sh
            ;;
        2)
            #Auswahl >Nein<
            sudo bash cloud/data/project/install.sh
            ;;
esac
