#!/bin/bash
# 
# Updated: 4-Aug-2016
#
# Install rockmongo
#
# By Saurabh Sudhir
# 2016

#################################################
# Header/name
#################################################
printf "\n####################\n"
printf "#  rockmongo.sh #\n#"
printf "####################\n\n"

######################
#  Set no casematch  #
######################
shopt -s nocasematch

#################################################
# Requires run as root (or sudo)
#################################################
printf "Checking UID...\n"
if (( EUID != 0 )); then
  printf "You must be root to do this, Please use 'sudo ./rockmongo.sh'.\n" 1>&2
	exit 10
else
	printf "User is root ...\n"
fi

#################################################
# User confirmation
#################################################
printf "\nThis installtion requires zip and unzip to be pre-installed.\n\nDo you want to install rockmongo (y/n)\n"
printf "> "
	read set_install_opt

#################################################
# Installing rockmongo
#################################################
if [[ ( "$set_install_opt" = y ) ]]
then
	printf "\nInstalling rockmongo ...\n"
	cd /srv
	sudo mkdir rockmongo
	cd rockmongo
	sudo wget https://github.com/diffion/rockmongo/archive/1.1.7.zip
	sudo unzip 1.1.7.zip
	sudo cp –r /srv/rockmongo/rockmongo-1.1.7/* /srv/rockmongo/
	sudo rm 1.1.7.zip
	cd /var/www/ 
	sudo ln -s /srv/rockmongo
	sudo rm -r /srv/rockmongo/rockmongo-1.1.7/
	printf "\nrockmongo is installed\n"
	printf "\nmodify rockmongo config file - set admin username and password\n"
	#nano /usr/share/rockmongo/config.php
	sudo service apache2 restart
fi
	
#################################################
# Exiting
#################################################
if [[ ( "$set_install_opt" = n ) ]]
then
	printf "Exiting...\n"
fi