#!/bin/bash
# 
# Updated: 4-Aug-2016
#
# Install php-composer
#
# By Saurabh Sudhir
# 2016

#################################################
# Header/name
#################################################
printf "\n####################\n"
printf "#  php-composer.sh #\n#"
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
  printf "You must be root to do this." 1>&2
	exit 10
else
	printf "User is root ...\n"
fi

#################################################
# User confirmation
#################################################
printf "\nDo you want to install php-composer (y/n)\n"
printf "> "
	read set_install_opt

#################################################
# Installing
#################################################
if [[ ( "$set_install_opt" = y ) ]]
then
	printf "\nInstalling php-composer ...\n"
	cd /srv/
	sudo curl -sS https://getcomposer.org/installer | php
	sudo mv composer.phar /usr/local/bin/composer
fi
	
#################################################
# Exiting
#################################################
if [[ ( "$set_install_opt" = n ) ]]
then
	printf "Exiting...\n"
fi