#!/bin/bash

#Shell leeren
clear

#Projektnamen aus Datei data/_temp/name auslesen
name=$(cat cloud/data/_temp/name)

#Webverzeichnis-Pfad generieren
web_folder="$name"

#Datenverzeichnis-Pfad generieren
mount_path="/media/""$name""_files"

#Header
figlet $name

printf "\n\n"

#Ausgabe der angeschlossenen Geräte
lsblk -o NAME,SIZE -d

#Abfrage der Bezeichnung der Festplatte
printf "\n\nWie lautet der >NAME< der Festplatte?:"
read device_name

sudo umount /dev/$device_name?*

#Festplatte einmal komplett formatieren
sudo mkfs.ext4 -F /dev/$device_name

#Programm zum Partitionieren der Festplatte aufrufen
sudo cfdisk /dev/$device_name

#Aus sda wird die Partition sda1
partition_number="1"
partition_name="$device_name$partition_number"

#Festplatten-Partition sda1 mit ext4-Dateisystem formatieren
sudo mkfs.ext4 /dev/$partition_name


#UUID abfragen und in eine Variable speichern
uuid=$(sudo blkid -o value -s UUID /dev/$partition_name)

fstab_line="UUID=\"$uuid\" $mount_path ext4 defaults 0 0"


sudo su -c "echo '$fstab_line' >> /etc/fstab"






#Partition mounten
sudo mount /dev/$partition_name $mount_path

#Rechte erteilen
sudo chown -R www-data:www-data $mount_path

sudo bash cloud/data/project/install.sh
