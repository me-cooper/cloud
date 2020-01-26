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

#../mysql/start.sh aufrufen
sudo bash cloud/data/mysql/start.sh
