#!/bin/bash
#
# Updated: 15-Feb-2016
#
# Installs, debugs, or removes a mysql server stack.
# Will also help configure the server.
#
# By Saurabh Sudhir
# 2016

#################################################
# Header/name
#################################################
printf "\n####################\n"
printf "#  mysql.sh #\n# By Saurabh #\n"
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
  printf "You must be root to do this, Please use 'sudo ./mysql.sh'.\n" 1>&2
	exit 10
else
	printf "User is root ...\n"
fi

#################################################
# Installing LAMP or Debugging?
#################################################
printf "\nAre you installing, debugging, or removing an existing mysql server?\n"
printf "(I)nstalling mysql.\n"
printf "(D)ebugging a current installation.\n"
printf "(R)emoving a current mysql installation.\n"
printf "(Q)uit.\n"
printf "> "
	read install_debug_rm

#################################################
# Installing LAMP server stack
#################################################
if [[ ( "$install_debug_rm" = i ) ]]
then
	# Update and Upgrade
	printf "\nUpdating ...\n"
	apt-get -qqq update
	
	##############################
	#  Install required packages #
	##############################
	# For on-screen installation log : apt-get -qqq 
	
	printf "\nInstalling mysql server...\n"
	apt-get -qqq install mysql-server
	mysql_secure_installation

	########################
	#   How to configure   #
	########################
	printf "\n\nTo configure MySQL type $ mysql -u root\n\n"
	# Unset casematch
	shopt -u nocasematch
	exit 0
fi

#################################################
# Debugging options
#################################################
if [[ ( "$install_debug_rm" = d ) ]]
then
	printf "Debugging ...\n"
	# Unset casematch
	shopt -u nocasematch
	exit 0
fi


#################################################
# Removing LAMP stack
#################################################
if [[ ( "$install_debug_rm" = r ) ]]
then
	printf "Removing LAMP ...\n"
	
	sudo apt-get purge -qqq mysql-server
	printf "LAMP stack removed ...\n"
	# Unset casematch
	shopt -u nocasematch
	exit 0
fi

if [[ ( "$install_debug_rm" = q ) ]]
then
	printf "Quitting ...\n"
	# Unset casematch
	shopt -u nocasematch
	exit 0
fi