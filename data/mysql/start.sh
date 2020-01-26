# !/bin/bash

#Frage
HEIGHT=15
WIDTH=70
CHOICE_HEIGHT=3
BACKTITLE="Datenbank-Konto"
TITLE="Datenbank-Konto"
MENU="\nHast du bereits ein Datenbank-Konto auf deinem Server?\n\n"

OPTIONS=(1 "Ja, einloggen"
         2 "Nein, Konto erstellen")

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
            #Auswahl >Ja<
            sudo bash cloud/data/mysql/create_db.sh
            ;;
        2)
            #Auswahl >Nein, ich hab keine Ahnung<
            sudo bash cloud/data/mysql/db_setup.sh
            ;;
esac
