#!/bin/bash
# 
# Updated: 10-Aug-2013
#
# Set data directory of mongodb
# Run this after mongodb has been successfully installed
#
# By Saurabh Sudhir
# 2013

#################################################
# Header/name
#################################################
printf "\n####################\n"
printf "# config-mongodb.sh #\n#"
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
	printf "You must be root to do this, Please use './config-mongodb'.\n" 1>&2
	exit 10
else
	printf "User is root ...\n"
fi

#################################################
# User confirmation
#################################################
printf "\n Do you want to set data & tmp directory (y/n) \n"
printf "> "
	read set_mongodb_dir

#################################################
# Configuring dir paths
#################################################
if [[ ( "$set_mongodb_dir" = y ) ]]
then
	# Create required directories
	printf "\n Enter path of the new data directory (e.g. /mnt) \n"
	printf "> "
	read read_mongodb_dir
	mkdir -p $read_mongodb_dir/data/
	mkdir -p $read_mysql_dir/log/
	chown -R mongodb:nogroup $read_mongodb_dir
	
	printf "\n Directories created and permissions set \n"
	printf "\n Stopping mongldb... \n"
	printf "\n Please modify config file \n"
	printf "\n\n modify dbpath & logpath \n\n"
	service mongodb stop
	nano /etc/mongodb.conf
	printf "\n Verify changes\n"
	printf "\n grep dbpath /etc/mongodb.conf \n"
	printf "\n grep logpath /etc/mongodb.conf \n"
	printf "\n\n Starting mongldb... \n\n"
	service mongodb start
else
		printf "\n You selected to exit ...\n"
fi
