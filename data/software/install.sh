#!/bin/bash

#Shell leeren
clear

#Alle Pakete, aufgelistet in: Datei >>software/packages<<, installieren
sudo xargs -a cloud/data/software/packages sudo apt-get install


#Nach der Installation der Pakete den Webserver neustarten
sudo systemctl restart apache2.service

#Apache2 Module aktivieren (für den Betrieb der Cloud lt. Software-Anforderung)
sudo a2enmod rewrite
sudo a2enmod headers
sudo a2enmod env
sudo a2enmod dir
sudo a2enmod mime

#Apache2-Webserver neustarten
sudo systemctl restart apache2.service

#Shell leeren
clear

#Nachricht, dass alle Pakete installiert wurden
printf "Alle benötigten Pakete wurden installiert!\n"

#project/new.sh aufrufen
sudo bash cloud/data/project/new.sh
