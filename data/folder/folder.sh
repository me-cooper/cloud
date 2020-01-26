#!/bin/bash

#Shell leeren
clear

#Name aus Datei "name" lesen
name=$(cat cloud/data/_temp/name)

#name wird zum Web-Verzeichnis
web_folder="$name"

#Datenverzeichnis wird /name_files
mount_folder="$web_folder""_files"

#Ordner /name im Webverzeichnis erstellen
sudo mkdir /var/www/html/$web_folder

#Webserver-Benutzer >www-data< wird Eigentümer von /name
sudo chown -R www-data:www-data /var/www/html/$web_folder

#Ordner /name_files für das Datenverzeichnis erstellen
sudo mkdir /media/$mount_folder

#Webserver-Benutzer >www-data< wird Eigentümer von /name_files
sudo chown -R www-data:www-data /media/$mount_folder

#../hdd/start.sh aufrufen
sudo bash cloud/data/hdd/start.sh
