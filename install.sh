#!/bin/bash

arch=$(uname -m)
kernel=$(uname -r)
if [ -n "$(command -v lsb_release)" ]; then
	distroname=$(lsb_release -s -d)
elif [ -f "/etc/os-release" ]; then
	distroname=$(grep PRETTY_NAME /etc/os-release | sed 's/PRETTY_NAME=//g' | tr -d '="')
elif [ -f "/etc/debian_version" ]; then
	distroname="Debian $(cat /etc/debian_version)"
elif [ -f "/etc/redhat-release" ]; then
	distroname=$(cat /etc/redhat-release)
else
	distroname="$(uname -s) $(uname -r)"
fi

if [ "${distroname}" == "Raspbian GNU/Linux 10 (buster)" ]; then
	#_temp Order erstellen
	sudo mkdir cloud/data/_temp
	#Temporäre Datei erstellen
	echo "" > cloud/data/_temp/base
	#Temp-Dateien löschen
	sudo rm -R cloud/data/_temp/*
	
	sudo bash cloud/data/cloud.sh
else
  printf "\nDein Betriebssystem wird nicht unterstützt!\nSystemupdate fällig!\n\nBenötigte Version:\nRaspbian GNU/Linux 10 (buster)\n\n"
	printf "Besuche: \n\n\t"
	printf "http://makesmart.net/makesmart-server-update/\n\n"
fi
