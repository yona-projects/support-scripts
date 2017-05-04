#!/bin/bash

# Script Version 20170504 by Minishanell

# Setting for YONA_DATA
YONA_DATA=/home/pi/yona_data

# Check of Yona_Version
echo ""
YONANOW=`ls |grep yona-`
YONAINSTALLED="1"
if [ $YONANOW ]; then
        echo -e "\033[33m Currunt Yona's Version : "$YONANOW;
        echo -e "\033[0m";
        YONAINSTALLED="1";
else
        echo -e "\033[31m Yona is Not Installed.";
        echo -e "\033[0m";
        YONAINSTALLED="0";
fi

# Choice for Upgrade by  Keyboard Input
read -n 1 -p "Do you want to Yona Upgrade(y/N)?"
echo "";echo ""
if [[ $REPLY = [yY] ]]; then
        echo -e "\033[33m Now, Yona will be Upgrade.";
        echo -e "\033[0m";
        if [ $YONAINSTALL ]
        then
#               # Sync & Shutdown Yona
                sudo sync;
                sudo sleep 1;
                sudo pid=`ps -ef | grep java | grep com.typesafe.play | awk '{print $2}'`;
                sudo kill $pid;
                sudo sync;
                sudo sleep 1;
                echo -e "\033[32m Yona is Shutdowned.";
                echo -e "\033[0m";
        fi

        # Paser for Latest Version Yona Address Link
        wget https://github.com/yona-projects/yona/releases/latest
        cat ./latest | grep '\<href="/yona.*.bin.zip\>' | grep -v 'h2' | cut -f 2 -d "\"" > downlink.yona
        rm ./latest
        INPUT=`cat ./downlink.yona`
        echo "https://github.com"$INPUT > downlink.yona
        INPUT=`cat ./downlink.yona`

        # Print Link Address
        echo "Link Address :" $INPUT
        echo ""

        # Download & Unzip Latest Version Yona
        wget $INPUT
        unzip ./yona*.zip
        rm ./yona*.zip

else
        echo -e "\033[31m Yona Upgrade is cancel.";
        echo -e "\033[0m";
fi

# Make a NewFolder Name
INPUT=`cat downlink.yona | cut -f 8 -d "/" | sed 's/v/-/g'`
echo "yona"$INPUT > version.yona

# Run Yona
#INPUT=`cat version.yona`
#cd ./$INPUT
#export YONA_DATA
#sudo ./bin/yona&
