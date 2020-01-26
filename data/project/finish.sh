#!/bin/bash

#Shell leeren
clear

#Projektnamen aus Datei data/_temp/name auslesen
name=$(cat cloud/data/_temp/name)

cloud_login=$(cat cloud/data/_temp/cloud_login)
cloud_pw=$(cat cloud/data/_temp/cloud_pw)

#Webverzeichnis-Pfad generieren
web_folder="$name"

#Datenverzeichnis-Pfad generieren
mount_folder="$name""_files"

#Willkommensnachricht
figlet $name
printf "Willkommen im 21. Jahrhundert mit $name! :-P\n\n"

ip_adress=$(ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1')"/""$web_folder"
hostname="http://"$(hostname)"/""$web_folder""/"

printf "\n\n\n\n"
printf "$ip_adress"
printf "\n"
printf "$hostname"
printf "\n\n\n\n"
printf "Login: $cloud_login"
printf "\n"
printf "Passwort: $cloud_pw"
printf "\n\n\n\n"

#Temp-Dateien löschen
sudo rm -R cloud/data/_temp/*
