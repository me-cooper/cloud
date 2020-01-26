#!/bin/bash

#Shell leeren
clear

#Meldung für den Benutzer
printf "Programme werden installiert...\n"

#Programm >figlet< installieren, um Header-Text zu erstellen
sudo bash -c 'apt-get -y install figlet'

#Programm >dialog< installieren, um Auswahlmenüs im Terminal anzeigen zu lassen
sudo bash -c 'apt-get -y install dialog'

#Shell leeren
clear

#Willkommensnachricht
figlet Willkommen

#Script data/install_packages.sh ausführen
sudo bash cloud/data/software/install.sh
