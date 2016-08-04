#!/bin/bash
#
# Updated: 4-Aug-2016
#
# Installs or removes mongodb.
#
# By Saurabh Sudhir
# 2016

#################################################
# Header/name
#################################################
printf "\n####################\n"
printf "#  install-mongodb.sh #\n#\n"
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
  printf "You must be root to do this, Please use 'sudo ./mongo'.\n" 1>&2
	exit 10
else
	printf "User is root ...\n"
fi

#################################################
# Installing LAMP or Debugging?
#################################################
printf "\nAre you installing or removing an existing mongodb server?\n"
printf "(I)nstalling mongodb server.\n"
printf "(R)emoving a current nstalling mongodb server.\n"
printf "(Q)uit.\n"
printf "> "
	read install_debug_rm

#################################################
# Installing mongodb server
#################################################
if [[ ( "$install_debug_rm" = i ) ]]
then
	sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
	echo "deb http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list
	
	# Update and Upgrade
	printf "\nUpdating ...\n"
	sudo apt-get -qqq update
	
	printf "\n Installing mongo...\n"
	sudo apt-get install -y mongodb-org
	printf "\nmongo installed"
	printf "\nchecking version.....\n"
	mongod --version
fi

#################################################
# Removing mongodb server
#################################################
if [[ ( "$install_debug_rm" = r ) ]]
then
	printf "Stopping mongo server ...\n"
	sudo service mongod stop
	
	printf "Removing mongo server ...\n"
	sudo apt-get purge mongodb-org*
	printf "mongo server removed ...\n"
	printf "Removing data directories ...\n"
	sudo rm -r /var/log/mongodb
	sudo rm -r /var/lib/mongodb
	# Unset casematch
	shopt -u nocasematch
	exit 0
fi