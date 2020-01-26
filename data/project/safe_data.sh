#!/bin/bash

#Shell leeren
clear

if [ "$(whoami)" != "root" ]
then
    sudo su -s "$0"
    exit
fi


hostname=$(cat cloud/data/_temp/hostname)
db_root_password=$(cat cloud/data/_temp/db_root_password)
db_user=$(cat cloud/data/_temp/db_user)
db_password=$(cat cloud/data/_temp/db_pass)
cloud_login=$(cat cloud/data/_temp/cloud_login)
cloud_pw=$(cat cloud/data/_temp/cloud_pw)
name=$(cat cloud/data/_temp/name)
mount_folder="$name""_files"
logged_in_user=$(cat cloud/data/_temp/logged_in_user)


#Alle Dateien aus dem Ordner löschen
rm -r /media/"$mount_folder"/"$cloud_login"/files/*

#Neuen Ordner erstellen
mkdir /media/"$mount_folder"/"$cloud_login"/files/"$hostname"

#Daten in Datei schreiben

/bin/cat <<EOM >cloud/data/_temp/daten.md
# $hostname

## Datenbank

##### Admin Account

\`\`\`
ID: root
PW: $db_root_password
\`\`\`

##### Dein Account

\`\`\`
ID: $db_user
PW: $db_password
\`\`\`

## Cloud

##### Dein Account

\`\`\`
ID: $cloud_login
PW: $cloud_pw
\`\`\`

##### Web-Verzeichnis

\`\`\`
/var/www/html/$name
\`\`\`

##### Datenverzeichnis

\`\`\`
/media/$mount_folder
\`\`\`

EOM



#Datei verschieben
sudo mv cloud/data/_temp/daten.md /media/"$mount_folder"/"$cloud_login"/files/"$hostname"/




#Rechte geben
sudo chown -R www-data:www-data /media/"$mount_folder"/"$cloud_login"/files/



#Ab ins Webroot-Verzeichnis wechseln
cd /var/www/html/$name

sudo -u www-data php occ files:cleanup

sudo -u www-data php occ files:scan --all

cd -

sudo bash ${PWD}/cloud/data/project/finish.sh
