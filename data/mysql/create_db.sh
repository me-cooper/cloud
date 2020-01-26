#!/bin/bash

#Shell leeren
clear

name=$(cat cloud/data/_temp/name)

#Willkommensnachricht
figlet Login
printf "\n\n\tName: "
read mysql_username
printf "\n\t\Passwort: "
read -s mysql_password

#Datenbank-Name wird db_$name
db_name="db_""$name"

#Datenbank erstellen und dir die Rechte dafür geben
sudo mysql -e "CREATE DATABASE $db_name"
sudo mysql -e "GRANT ALL PRIVILEGES ON $db_name . * TO '$mysql_username'@'localhost'"
sudo mysql -e "FLUSH PRIVILEGES"

#Temporäre Datei erstellen
echo "$mysql_username" > cloud/data/_temp/db_user

#Temporäre Datei erstellen
echo "$mysql_password" > cloud/data/_temp/db_pass

#../folder/folder.sh ausführen
sudo bash cloud/data/folder/folder.sh
