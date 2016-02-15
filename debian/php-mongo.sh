#!/bin/bash
# 
# Updated: 15-Feb-2016
#
# Install php-mongo
#
# By Saurabh Sudhir
# 2016

#################################################
# Header/name
#################################################
printf "\n####################\n"
printf "#  php-mongo.sh #\n#"
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
  printf "You must be root to do this, Please use 'sudo ./php-mongo.sh'.\n" 1>&2
	exit 10
else
	printf "User is root ...\n"
fi

#################################################
# User confirmation
#################################################
printf "\nDo you want to install php-mongo (y/n)\n"
printf "> "
	read set_install_opt

#################################################
# Installing php-mongo
#################################################
if [[ ( "$set_install_opt" = y ) ]]
then
	printf "\nInstalling php-mongo ...\n"
	apt-get -qqq install php5-dev
	apt-get -qqq install make
	sudo pecl install mongo
	printf "\nAdd mongo.so to php.ini [line: 853] to load this extension...\n"
fi
	
#################################################
# Exiting
#################################################
if [[ ( "$set_install_opt" = n ) ]]
then
	printf "Exiting...\n"
fi