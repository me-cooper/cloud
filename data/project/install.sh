#!/bin/bash

#Shell leeren
clear

#Projektnamen aus Datei data/_temp/name auslesen
name=$(cat cloud/data/_temp/name)
#db_user aus Datei data/_temp/name auslesen
db_user=$(cat cloud/data/_temp/db_user)
#db_pass aus Datei data/_temp/name auslesen
db_pass=$(cat cloud/data/_temp/db_pass)

#Webverzeichnis-Pfad generieren
web_folder="$name"

#Datenverzeichnis-Pfad generieren
mount_path="/media/""$name""_files"

#Willkommensnachricht
figlet Installation


#Software installieren
cd /var/www/html/$web_folder


sudo wget "https://download.nextcloud.com/server/releases/nextcloud-18.0.0.zip" -O "$name".zip
sudo unzip "$name".zip
sudo rm "$name".zip

clear
clear
printf "Warte... Cloud wird entpackt.\n"
sudo cp -a nextcloud/. .
clear
printf "Gleich gehts weiter ... Dateien werden gelöscht.\n"
sudo rm nextcloud
clear

figlet $name
printf "Erstelle dein Cloud-Login\n\n"
printf "\t\tBenutzername: "
read cloud_username
printf "\n\t\tPasswort: "
read -s cloud_password




printf "Bitte warten...\n\n"

printf "\n\n$name wird eingerichtet...\n\n\n"
#Webserver-Benutzer >www-data< wird  Eigentümer von /name
sudo chown -R www-data:www-data /var/www/html/$web_folder

sudo -u www-data php occ maintenance:install --database "mysql" --database-name "db_""$name"  --database-user "$db_user" --database-pass "$db_pass" --admin-user "$cloud_username" --admin-pass "$cloud_password" --data-dir "$mount_path"

sudo -u www-data php occ db:add-missing-indices
echo "y"

sudo -u www-data php occ db:convert-filecache-bigint
echo "y"

sudo -u www-data php occ upgrade

sudo -u www-data php occ config:system:set trusted_domains 1 --value=$(ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1')

sudo -u www-data php occ config:system:set trusted_domains 2 --value=$(hostname)

#Lokaler Cache definieren
sudo -u www-data php occ config:system:set memcache.local --value='\OC\Memcache\APCu'

#PHP memory_limit ändern
temp_php_v=$(php -v|grep --only-matching --perl-regexp "(PHP )\d+\.\\d+")
cut_string="PHP "
php_v=${temp_php_v//$cut_string/}
php_path="/etc/php/""$php_v""/apache2/"

sudo sed -i 's/memory_limit = 128M/memory_limit = 512M/g' "$php_path""php.ini"

cd -

#Benutzername in Datei ebelegen
echo "$cloud_username" > cloud/data/_temp/cloud_login
#PW in Datei ebelegen
echo "$cloud_password" > cloud/data/_temp/cloud_pw

sudo bash ${PWD}/cloud/data/project/safe_data.sh
