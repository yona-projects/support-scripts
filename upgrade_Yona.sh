#!/bin/bash

# Script Version 20170504 by Minishanell 

# Setting for YONA_DATA
YONA_DATA=/home/pi/yona_data

# Sync & Shutdown Yona
sudo sync
sudo sleep 1
sudo pid=`ps -ef | grep java | grep com.typesafe.play | awk '{print $2}'`
sudo kill $pid
sudo sync
sudo sleep 1

# Paser for Latest Version Yona Address Link
wget https://github.com/yona-projects/yona/releases/latest
cat ./latest |grep '\<href="/yona.*.bin.zip\>' | grep -v 'h2' | cut -f 2 -d "\""                                                                                                                                                              > downlink.yona
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

# Make a NewFolder Name
INPUT=`cat downlink.yona | cut -f 8 -d "/" | sed 's/v/-/g'`
echo "yona"$INPUT > version.yona

# Run Yona
#INPUT=`cat version.yona`
#cd ./$INPUT
#export YONA_DATA
#sudo ./bin/yona&