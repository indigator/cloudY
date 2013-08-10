#!/bin/bash
#
# Updated: 10-Aug-2013
#
# Installs or removes mongodb.
#
# By Saurabh Sudhir
# 2013

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
  printf "You must be root to do this, Please use 'sudo ./install-mongo'.\n" 1>&2
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
	sudo apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10
	cat > /etc/apt/sources.list.d/mongodb.list << EOF
deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen
EOF
	
	# Update and Upgrade
	printf "\nUpdating ...\n"
	apt-get -qqq update
	printf "\n Installing mongodb...\n"
	apt-get -qqq install mongodb-10gen
	printf "\nmongodb installed"
	printf "\n Installing python connector...\n"
	apt-get -qqq install python-pip
	pip install pymongo
fi

#################################################
# Removing mongodb server
#################################################
if [[ ( "$install_debug_rm" = r ) ]]
then
	printf "Removing mongodb server ...\n"
	
	sudo apt-get purge -qqq mongodb
	printf "mongodb server removed ...\n"
	# Unset casematch
	shopt -u nocasematch
	exit 0
fi
