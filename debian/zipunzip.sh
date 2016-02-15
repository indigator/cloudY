#!/bin/bash
#
# Updated: 15-Feb-2016
#
# Install zip/unzip
#
# By Saurabh Sudhir
# 2016

#################################################
# Header/name
#################################################
printf "\n####################\n"
printf "#  zipunzip.sh #\n# By Saurabh #\n" 
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
  printf "You must be root to do this, Please use 'sudo ./zipunzip'.\n" 1>&2
	exit 10
else
	printf "User is root ...\n"
fi

#################################################
# Install Zip/Unzip?
#################################################
printf "\nWould you like to install zip/unzip?\n"
printf "(Y)es.\n"
printf "(R)emove.\n"
printf "(Q)uit.\n"
printf "> "
	read install_debug_rm

if [[ ( "$install_debug_rm" = y ) ]]
then
	printf "\nInstalling zip and unzip ...\n"
	apt-get -qqq install unzip
	apt-get -qqq install zip
fi

if [[ ( "$install_debug_rm" = r ) ]]
	printf "\nRemoving zip and unzip ...\n"
	apt-get -qqq remove unzip
	apt-get -qqq remove zip
fi

printf "\nExiting ...\n"
# Unset casematch
shopt -u nocasematch
exit 0