#!/bin/bash
#
# Updated: 10-Aug-2013
#
# Installs, debugs, or removes a LAMP server stack.
# Will also help configure the server.
#
# By Saurabh Sudhir
# 2013

#################################################
# Header/name
#################################################
printf "\n####################\n"
printf "#  install-lamp.sh #\n# By Saurabh #\n"
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
printf "\nAre you installing, debugging, or removing an existing LAMP server stack?\n"
printf "(I)nstalling LAMP stack.\n"
printf "(D)ebugging a current installation.\n"
printf "(R)emoving a current LAMP installation.\n"
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
	
	printf "\nSetting Timezone ...\n"
	echo "Asia/Kolkata" | sudo tee /etc/timezone
	sudo dpkg-reconfigure --frontend noninteractive tzdata
	
	##############################
	#  Install required packages #
	##############################
	# For on-screen installation log : apt-get -qqq 
	
	printf "\nInstalling LAMP stack...\n"
	apt-get -qqq install apache2 apache2-doc apache2-utils libapache2-mod-php5 php5 php-pear php5-xcache php5-gd php5-mcrypt php5-mysql curl libcurl3 libcurl3-dev php5-curl
	#printf "\nWould you like to set data directory for mysql (y/n)\n"
	#read serv_mysql_data

	#if [[ ( "$serv_mysql_data" = y ) ]]
	#then
	#	printf "\nEnter path of the data directory\n"
	#	read serv_mysql_data_path
	#	apt-get -qqq install mysql-server --datadir=$serv_mysql_data_path
	#else
	apt-get -qqq install mysql-server
	#fi
	
	mysql_secure_installation
	apt-get -qqq install phpmyadmin
	cd /var/www/ 
	ln -s /usr/share/phpmyadmin
	printf "\Enabling apache mods...\n"
	a2enmod rewrite
	a2enmod expires
	a2enmod headers

	#############################
	#     Configure packages    #
	#############################

	printf "\nWould you like to add 'ServerName localhost' to /etc/apache2/conf.d/fqdn? (y/n)\n"
	printf "If this is a development box or you're not sure type y to be safe.\n"
	printf "> "
	read serv_local

	if [[ ( "$serv_local" = y ) ]]
	then
		echo "ServerName localhost" >> /etc/apache2/conf.d/fqdn
	else
		printf "Nothing was added to /etc/apache2/conf.d/fqdn ...\n"
	fi
	
	printf "\nWould you like to install zip and unzip (y/n)\n"
	printf "> "
	read serv_local_zip

	if [[ ( "$serv_local_zip" = y ) ]]
	then
		apt-get install unzip
		apt-get install zip
	else
		printf "\nzip and unzip not installed...\n"
	fi

	######################
	#   Restart Apache   #
	######################
	printf "\nRestarting apache2 ...\n"
	/etc/init.d/apache2 restart

	########################
	#   How to configure   #
	########################
	printf "\n\nTo configure MySQL type $ mysql -u root\n\n"
	printf "For other computers on your network to see the server\n"
	printf "edit the 'bind-address = 127.0.0.1' line in\n"
	printf "your /etc/mysql/my.cnf to your IP address.\n\n"
	
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
	
	sudo apt-get purge -qqq apache2 apache2-doc apache2-utils libapache2-mod-php5 php5 php-pear php5-xcache php5-gd php5-mcrypt php5-mysql curl libcurl3 libcurl3-dev php5-curl mysql-server phpmyadmin
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
