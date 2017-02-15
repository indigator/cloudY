#!/bin/bash
#
# Updated: 9-Feb-2017
#
# Installs, debugs, or removes a LAP server stack.
# Will also help configure the server.
#
# By Saurabh Sudhir
# 2017

#################################################
# Header/name
#################################################
printf "\n####################\n"
printf "#  install-lap.sh #\n# By Saurabh #\n"
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
  printf "You must be root to do this, Please use 'sudo ./install-lamp'.\n" 1>&2
	exit 10
else
	printf "User is root ...\n"
fi

#################################################
# Installing LAMP or Debugging?
#################################################
printf "\nAre you installing, debugging, or removing an existing LAP server stack?\n"
printf "(I)nstalling LAP stack.\n"
printf "(D)ebugging a current installation.\n"
printf "(R)emoving a current LAP installation.\n"
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
	echo "deb http://packages.dotdeb.org jessie all" | sudo tee -a /etc/apt/sources.list
	wget https://www.dotdeb.org/dotdeb.gpg
	sudo apt-key add dotdeb.gpg
	sudo apt-get -qqq update
	
	##############################
	#  Install required packages #
	##############################
	# For on-screen installation log : apt-get -qqq 
	
	printf "\nInstalling LAMP stack...\n"
	sudo apt-get -qqq install apache2 apache2-doc apache2-utils curl libcurl3 libcurl3-dev mysql-client
	sudo apt-get -qqq install php7.0 php-pear php7.0-gd mcrypt php7.0-mcrypt php7.0-mysql php7.0-curl php7.0-bcmath
	printf "\Enabling apache mods...\n"
	sudo a2enmod rewrite
	sudo a2enmod expires
	sudo a2enmod headers

	######################
	#   Restart Apache   #
	######################
	printf "\nRestarting apache2 ...\n"
	sudo /etc/init.d/apache2 restart
		
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
	
	sudo apt-get purge -qqq apache2 apache2-doc apache2-utils curl libcurl3 libcurl3-dev mysql-client
	sudo apt-get purge -qqq php7.0 php-pear php7.0-gd php7.0-mcrypt php7.0-mysql php7.0-curl
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
