#!/bin/bash

version="2.1.3"

###############################################################################
# Load All Functions                                                          #
###############################################################################

# Function Show script help
function showHelp {
        clear
        echo "Remove Parallels $version"
        echo 
        echo 'Usage: $0 [option]'
        echo 
        echo 'Option:'
        echo '  -h | --help            This help file'
        echo '  -r | --remove          Remove Parallels completely'
        echo '  -s | --save-license    Remove Parallels, save License'
        echo 
}   # end of showHelp

# request `sudo` access
function reqSudo {
sudo -v
}   # end of reqSudo

# keep-alive
function keepAlive {
while true; do sudo -n true; sleep 60; kill -0 '$$' || exit; done 2>/dev/null &
}   # end of keepAlive

# stop parallels service
function stopPrls {
for pid in $(ps aux | grep "Parallels Desktop.app" | awk '{print $2}'); do echo kill -KILL $pid; done
for kext in $(kextstat | grep parallels | awk '{print $6}'); do kextunload $kext; done
}   # end of stopPrls

# remove XML License
function remLicense {
sudo rm /Library/Preferences/Parallels/licenses.xml
}   # end of remLicense

# save XML License
function saveLicense {
mkdir "~/Desktop/Saved\ Parallels\ License"
mv /Library/Preferences/Parallels/licenses.xml ~/Desktop/Saved\ Parallels\ Licence/licenses.xml
curl https://raw.github.com/danijeljames/remparallels/master/Removed-License.txt -o ~/Desktop/Saved\ Parallels\ Licence/Removed-License.txt
}   # end of saveLicense

# remove User Library data
function remULibrary {
sudo rm -rf ~/Library/Preferences/com.parallels.*
sudo rm -rf ~/Library/Preferences/Parallels/*
sudo rm -rf ~/Library/Preferences/Parallels*
sudo rm -rf ~/Library/Preferences/parallels/*
sudo rm -rf ~/Library/Preferences/parallels*
sudo rm -rf ~/Library/Parallels/
sudo rm -rf ~/Library/Logs/Parallels*
sudo rm -rf ~/Library/Logs/parallels*
sudo rm -rf ~/Library/Saved\ Application\ State/com.parallels.*/*
sudo rm -rf ~/Library/Saved\ Application\ State/com.parallels.*
}

# remove System Library Data
function remSLibrary {
sudo rm -rf /Library/Logs/parallels*
sudo rm -rf /Library/Logs/Parallels*
sudo rm -rf /Library/logs/parallels.log
sudo rm -rf /Library/Preferences/com.parallels*
sudo rm -rf /Library/Preferences/Parallels/*
sudo rm -rf /Library/Preferences/Parallels
}

# remove Core Application Data
function remCoreData {
sudo rm -rf /private/var/db/parallels/stats/*
sudo rm -rf /private/var/db/Parallels/stats/*
sudo rm -rf /private/var/db/parallels/stats
sudo rm -rf /private/var/db/Parallels/stats
sudo rm -rf /private/var/db/parallels
sudo rm -rf /private/var/.parallels_swap
sudo rm -rf /private/var/.Parallels_swap
sudo rm -rf /private/var/db/receipts/'com.parallels*'
sudo rm -rf /private/var/root/library/preferences/com.parallels.desktop.plist
sudo rm -rf /private/tmp/qtsingleapp-*-lockfile
sudo rm -rf /private/tmp/com.apple.installer*/*
sudo rm -rf /private/tmp/com.apple.installer*
sudo rm /System/Library/Extensions/prl*
}

# clean up
function cleanUp {
sudo periodic daily weekly monthly
}

# Function call -r
function callR {
reqSudo
keepAlive
stopPrls
remLicense
remULibrary
remSLibrary
remCoreData
cleanUp
}   # end of callR

# Function call -s
function callS {
reqSudo
keepAlive
stopPrls
saveLicense
remULibrary
remSLibrary
remCoreData
cleanUp
}   # end of callS

###############################################################################
# Standard UI                                                                 #
###############################################################################

case $1 in
        -h | --help )           showHelp
                                exit
                                ;;
        -r | --remove )         callR
                                exit
                                ;;
        -s | --save-license )   callS   
                                exit
                                ;;
        * )                     showHelp
                                exit 1
esac
