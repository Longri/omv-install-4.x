#!/bin/bash 

echo
echo -e "\033[36m Autoinstaller für Openmediavault 4.x und Extras.org\033[0m"
echo
echo -e "\033[36m Author:     Wolf2000\033[0m"
echo -e "\033[36m Version:         1.1\033[0m"
echo -e "\033[36m https://forum-bpi.de\033[0m"
echo -e "\033[31m Achtung das ist eine OMV-Test es kann eventuell nicht lauffähig sein \033[0m"
echo
echo -e "\033[32m Wolle sie Openmediaut mit Plugins installieren\033[0m"
echo -e "\033[32m Ihre Antwort, n/j:\033[0m"
read answer
#echo Das installieren wurde abgebrochen
echo  Ihre Antwort war: $answer
# if [ "$answer" = "j" ]
if [ "$answer" != "n" ]
  then 
	sudo apt-get update &&
	sleep 5
	sudo apt-get upgrade -y &&
	sleep 5
	sudo apt-get install mc  dvb-apps python-requests python-setuptools python-dev build-essential libpcre3-dev libdvbcsa-dev git libcurl4-gnutls-dev debhelper cmake build-essential pkg-config libssl-dev gettext dvb-tools libdvbv5-0 liburiparser-dev liburiparser1 libavahi-client-dev zlib1g-dev libavcodec-dev libavutil-dev libavformat-dev libswscale-dev -y &&
        sleep 5
	cd /usr/src &&
	sleep 5
	sudo git clone -b release/4.2 https://github.com/tvheadend/tvheadend &&
	sleep 5
	cd tvheadend &&
	sleep 5
	#compile TVHeadend without ffmpeg (arm64 dosen#t support the ffmpeg)
	AUTOBUILD_CONFIGURE_EXTRA=--disable-bintray_cache\ --disable-hdhomerun_static\ --disable-ffmpeg_static\  ./Autobuild.sh &&
	sleep 5
	
	#install compiled TVHeadend
	cd ..
	sleep 5
	sudo apt install ./tvheadend_4.2.7-22~gad7f16823_arm64.deb
	sleep 5
	
	# install openmediavault
	echo "deb http://packages.openmediavault.org/public arrakis main" > /etc/apt/sources.list.d/openmediavault.list &&
	sleep 5
	apt install --force-yes curl wget apt-transport-https dirmngr &&
	sleep 5
	gpg --recv-keys 7E7A6C592EF35D13 &&
	sleep 5
	gpg --export 7E7A6C592EF35D13 |apt-key add - &&
	sleep 5
	gpg --recv-keys 7E7A6C592EF35D13 &&
	sleep 5
	gpg --export 7E7A6C592EF35D13 |apt-key add - &&
	sleep 5
	gpg --recv-keys 24863F0C716B980B &&
	sleep 5
	gpg --export 24863F0C716B980B |apt-key add - &&
	sleep 5
	gpg --recv-keys 24863F0C716B980B &&
	sleep 5
	gpg --export 24863F0C716B980B |apt-key add - &&
	sleep 1
	apt update &&
	sleep 1
	apt-get install --force-yes openmediavault-keyring postfix ssl-cert &&
	sleep 1
	apt update &&
	sleep 1
	apt-get --yes --force-yes --allow-unauthenticated install openmediavault &&
	sleep 1
	wget http://omv-extras.org/openmediavault-omvextrasorg_latest_all4.deb
	sleep 1
	dpkg -i openmediavault-omvextrasorg_latest_all4.deb
	sleep 1
	apt-get -f install
	sleep 1
	apt update
	echo
	echo
	echo -e "\033[32m Das wars Openmediavult und Extras.org ist jetzt Installiert\033[0m"
else 
	echo -e "\033[31m Die Installation wurde abgebrochen\033[0m"
fi

