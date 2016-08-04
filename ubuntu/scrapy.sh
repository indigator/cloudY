#!/bin/bash
#
# Updated: 10-Aug-2013
#
# Installs scrapy.
#
# By Saurabh Sudhir
# 2013

#################################################
# Header/name
#################################################
printf "\n####################\n"
printf "#  install-scrapy.sh #\n#\n"
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
  printf "You must be root to do this, Please use 'sudo ./install-scrapy'.\n" 1>&2
	exit 10
else
	printf "User is root ...\n"
fi

#################################################
# Installing LAMP or Debugging?
#################################################
printf "\nAre you sure you wanna install scrapy?\n"
printf "(I)nstall scrapy.\n"
printf "(Q)uit.\n"
printf "> "
	read install_debug_rm

#################################################
# Installing scrapy
#################################################
if [[ ( "$install_debug_rm" = i ) ]]
then
	sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 7AECB5E990E2741A
	cat > /etc/apt/sources.list.d/scrapy.list << EOF
deb http://archive.scrapy.org/ubuntu precise main
EOF
	# Update and Upgrade
	printf "\nUpdating ...\n"
	apt-get -qqq update
	printf "\n Installing scrapy...\n"
	apt-get -qqq install scrapy-0.15
	printf "\nscrapy installed...\n"
	printf "\n Installing python mysql connector...\n"
	apt-get -qqq install python-mysqldb
fi

#################################################
# Exiting
#################################################
if [[ ( "$install_debug_rm" = q ) ]]
then
	printf "Exiting ...\n"
fi
