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
printf "\nDo you want to set data & tmp directory (y/n)\n"
printf "> "
	read set_mongodb_dir

#################################################
# Configuring dir paths
#################################################
if [[ ( "$set_mongodb_dir" = y ) ]]
then
	# Create required directories
	printf "\nEnter path of the new data directory (e.g. /mnt)\n"
	printf "> "
	read read_mongodb_dir
	mkdir -p $read_mongodb_dir/data/
	mkdir -p $read_mysql_dir/log/
	chown -R mongodb:nogroup $read_mongodb_dir
	
	printf "\nDirectories created and permissions set\n"
	printf "\nStopping mongldb...\n"
	printf "\nPlease modify config file\n"
	printf "\n\n modify dbpath & logpath \n\n"
	service mongodb stop
	nano /etc/init/mongodb.conf
	printf "\nVerify changes\n"
	printf "\ngrep dbpath /etc/init/mongodb.conf\n"
	printf "\ngrep logpath /etc/init/mongodb.conf\n"
	printf "\n\n Starting mongldb... \n\n"
	service mongodb start
else
		printf "You selected to exit ...\n"
fi
