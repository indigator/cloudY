#!/bin/bash
# 
# Updated: 10-Aug-2013
#
# Set data directory of mysql
# Run this after mysql has been successfully installed
#
# By Saurabh Sudhir
# 2013

#################################################
# Header/name
#################################################
printf "\n####################\n"
printf "#  config-mysql.sh #\n#"
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
  printf "You must be root to do this, Please use 'sudo ./config-mysql'.\n" 1>&2
	exit 10
else
	printf "User is root ...\n"
fi

#################################################
# User confirmation
#################################################
printf "\nDo you want to set data & tmp directory (y/n)\n"
printf "> "
	read set_mysql_dir

#################################################
# Configuring dir paths
#################################################
if [[ ( "$set_mysql_dir" = y ) ]]
then
	# Create required directories
	printf "\nStopping mysql server...\n"
	printf "\nPlease modify config file\n"
	printf "\n\n modify datadir under [mysqld] \n\n"
	printf "\n set datadir=NEW_PATH/mysql \n\n"
	service mysql stop
	nano /etc/mysql/my.cnf
	printf "\nVerify changes\n"
	printf "grep datadir /etc/mysql/my.cnf"
	printf "\n\n Starting mysql... \n\n"
	service mysql start
else
		printf "You selected to exit ...\n"
fi
