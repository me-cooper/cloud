#!/bin/bash

#Shell leeren
clear

#Willkommensnachricht
figlet Neue Cloud

#Name der Cloud abfragen
printf "Name der Cloud: "
read project_name

#Temporäre Datei erstellen
echo "$project_name" > cloud/data/_temp/name

#Temporäre Datei erstellen
echo $(hostname) > cloud/data/_temp/hostname
echo $(whoami) > cloud/data/_temp/logged_in_user

#../mysql/start.sh aufrufen
sudo bash cloud/data/mysql/start.sh
