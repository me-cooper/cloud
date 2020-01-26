#!/bin/bash

#Shell leeren
clear

name=$(cat cloud/data/_temp/name)
db_root_password=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 10 | head -n 1)


#Willkommensnachricht
figlet Datenbank
printf "\nDatenbank wird eingerichtet...\n\n"

#Root-Passwort setzen
mysql -e "UPDATE mysql.user SET Password = PASSWORD('$db_root_password') WHERE User = 'root'"
#Anonymen Benutzer löschen
mysql -e "DROP USER ''@'localhost'"
mysql -e "DROP USER ''@'$(hostname)'"
mysql -e "DROP DATABASE test"
#Rechte aktualisieren
mysql -e "FLUSH PRIVILEGES"


#Temporäre Datei erstellen
echo "$db_root_password" > cloud/data/_temp/db_root_password


#../mysql/create_user.sh auführen
sudo bash cloud/data/mysql/create_user.sh
