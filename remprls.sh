#!/bin/bash
echo
echo
echo Parallels Removal Tool
echo
echo
read -p "Press [Enter] key to begin process...]
echo
echo
echo Stopping Parallels Service
sleep 2
for pid in $(ps aux | grep "Parallels Desktop.app" | awk '{print $2}'); do echo kill -KILL $pid; done
for kext in $(kextstat | grep parallels | awk '{print $6}'); do kextunload $kext; done
echo
echo Remove Parallels Licence
sleep 2
sudo rm /Library/Preferences/Parallels/licences.xml
echo
echo Removing Parallels Application
sleep 2
rm -rf /Application/Parallels*
echo
echo  Removing User Library Data
sleep 2
rm -rf ~/Library/Preferences/com.parallels.*
rm -rf ~/Library/Preferences/Parallels/*
rm -rf ~/Library/Preferences/Parallels*
rm -rf ~/Library/Preferences/parallels/*
rm -rf ~/Library/Preferences/parallels*
rm -rf ~/Library/Parallels/
rm -rf ~/Library/Logs/Parallels*
rm -rf ~/Library/Logs/parallels*
rm -rf ~/Library/Saved\ Application\ State/com.parallels.*/*
rm -rf ~/Library/Saved\ Application\ State/com.parallels.*
echo
echo Removing Shared User Library Data
sleep 2
rm -rf /Users/Shared/Parallels/
echo
echo Removing System Library Data
sleep 3
rm -rf /Library/Logs/parallels*
rm -rf /Library/Logs/Parallels*
rm -rf /Library/logs/parallels.log
rm -rf /Library/Preferences/com.parallels*
rm -rf /Library/Preferences/Parallels/*
rm -rf /Library/Preferences/Parallels
echo
echo Core Application Data
sleep 3
rm -rf /private/var/db/parallels/stats/*
rm -rf /private/var/db/Parallels/stats/*
rm -rf /private/var/db/parallels/stats
rm -rf /private/var/db/Parallels/stats
rm -rf /private/var/db/parallels
rm -rf /private/var/.parallels_swap
rm -rf /private/var/.Parallels_swap
rm -rf /private/var/db/receipts/'com.parallels*'
rm -rf /private/var/root/library/preferences/com.parallels.desktop.plist
rm -rf /private/tmp/qtsingleapp-*-lockfile
rm -rf /private/tmp/com.apple.installer*/*
rm -rf /private/tmp/com.apple.installer*
rm /System/Library/Extensions/prl*
echo
echo Cleaning up...this may take a few minutes
sleep 2
periodic daily weekly monthly
echo
echo Finishing everything up
echo
sleep 2
killall Terminal




