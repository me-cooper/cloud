#!/bin/bash

#Shell leeren
clear

name=$(cat cloud/data/_temp/name)

#Willkommensnachricht
figlet Registrieren
printf "\nErstelle dein Server-Konto\n\n"
printf "\tKeine Sonderzeichen\n"
printf "\tKeine Leertaste\n"
printf "\tnur Buchstaben und Zahlen\n\n\t\t"
printf "Name: "
read mysql_username
printf "\n\t\tPasswort: "
read -s mysql_password

#Datenbank-Name wird db_$name
db_name="db_""$name"

#Datenbank + Dich erstellen und dann: dir die Rechte für Datenbank geben
sudo mysql -e "CREATE USER '$mysql_username'@'localhost' IDENTIFIED BY '$mysql_password'"
sudo mysql -e "CREATE DATABASE $db_name"
sudo mysql -e "GRANT ALL PRIVILEGES ON $db_name . * TO '$mysql_username'@'localhost'"
sudo mysql -e "FLUSH PRIVILEGES"

#Temporäre Datei erstellen
echo "$mysql_username" > cloud/data/_temp/db_user

#Temporäre Datei erstellen
echo "$mysql_password" > cloud/data/_temp/db_pass


#../folder/folder.sh auführen
sudo bash cloud/data/folder/folder.sh
