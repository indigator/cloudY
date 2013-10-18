#!/bin/bash
# 
# Updated: 10-Aug-2013
#
# Install rockmongo
#
# By Saurabh Sudhir
# 2013

#################################################
# Header/name
#################################################
printf "\n####################\n"
printf "#  rockmongo-install.sh #\n#"
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
  printf "You must be root to do this, Please use 'sudo ./install-rockmongo'.\n" 1>&2
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
	printf "\nInstalling pre-requisite php_mongo ...\n"
	apt-get install make
	sudo pecl install mongo
	printf "\nAdd mongo.so to php.ini [line: 944] to load this extension...\n"
	printf "\nInstalling rockmongo ...\n"
	cd /srv
	mkdir rockmongo
	cd rockmongo
	wget http://rockmongo.com/release/rockmongo-1.1.5.zip
	unzip rockmongo-1.1.5.zip
	mkdir -p /usr/share/rockmongo/
	cp –r /srv/rockmongo/rockmongo/ /usr/share/rockmongo/
	cd /var/www/ 
	ln -s /usr/share/rockmongo
	printf "\nrockmongo is installed\n"
	printf "\nmodify rockmongo config file - set admin username and password\n"
	nano /usr/share/rockmongo/config.php
	sudo service apache2 restart
fi
	
#################################################
# Exiting
#################################################
if [[ ( "$set_install_opt" = n ) ]]
then
	printf "Exiting...\n"
fi
