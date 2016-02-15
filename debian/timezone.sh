#!/bin/bash
#
# Updated: 15-Feb-2016
#
# Setup Time Zone
#
# By Saurabh Sudhir
# 2016

#################################################
# Header/name
#################################################
printf "\n####################\n"
printf "#  timezone.sh #\n# By Saurabh #\n" 
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
  printf "You must be root to do this, Please use 'sudo ./timezone'.\n" 1>&2
	exit 10
else
	printf "User is root ...\n"
fi

#################################################
# Setup Timezone?
#################################################
printf "\nWould you like to set Timezone?\n"
printf "(I)ST - Indian Standard Time.\n"
printf "(U)UTC - Coordinated Universal Time.\n"
printf "(Q)uit.\n"
printf "> "
	read install_debug_rm

if [[ ( "$install_debug_rm" = i ) ]]
then
	printf "\nSetting to IST Timezone ...\n"
	echo "Asia/Kolkata" | sudo tee /etc/timezone
	sudo dpkg-reconfigure --frontend noninteractive tzdata
	sudo /etc/init.d/cron restart
fi

if [[ ( "$install_debug_rm" = u ) ]]
	printf "\nSetting to UTC Timezone ...\n"
	echo "Etc/UTC" | sudo tee /etc/timezone
	sudo dpkg-reconfigure --frontend noninteractive tzdata
	sudo /etc/init.d/cron restart
fi

printf "\nExiting ...\n"
# Unset casematch
shopt -u nocasematch
exit 0