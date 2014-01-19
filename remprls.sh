#!/bin/sh

# Copyright (c) 2013-2014, Danijel James.

# Permission is hereby granted, free of charge, to any person obtaining a copy of
# this software and associated documentation files (the "Software"), to deal in
# the Software without restriction, including without limitation the rights to
# use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
# the Software, and to permit persons to whom the Software is furnished to do so,
# subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
# FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
# COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
# IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
# CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

program=`basename $0`

version="3.0.3"

if [ $# = 0 ]
then
    echo "usage: $program [option]"
    echo ""
    echo "$program Version $version"
    echo ""
    echo "Option:"
    echo "   -r   Remove Parallels"
    echo "   -s   Save License and Remove"
    exit 1
fi


# Stop Parallels if running and unload Kernel Extensions
stopPrls() {
echo "Stopping Parallels"
sleep 5
for pid in $(ps aux | grep "Parallels*" | awk '{print $2}'); do kill -HUP $pid; done
echo "Unloading Kernel Extensions"
sleep 5
for kext in $(kextstat | grep parallels | awk '{print $6}'); do kextunload $kext; done
}

# remove User Library data
remULibrary() {
echo "Removing User Library Data"
sleep 5
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
remSLibrary() {
echo "Removing System Library Data"
sleep 5
sudo rm -rf /Library/Logs/parallels*
sudo rm -rf /Library/Logs/Parallels*
sudo rm -rf /Library/logs/parallels.log
sudo rm -rf /Library/Preferences/com.parallels*
sudo rm -rf /Library/Preferences/Parallels/*
sudo rm -rf /Library/Preferences/Parallels
}

# remove Core Application Data
remCoreData() {
echo "Removing Core Application Data"
sleep 5
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

advRestart() {
echo "It is advised you restart your system"
echo "to complete the removal process..."
sleep 5
}

args=
for arg in $*; do
    case $arg in
	-r)
		sudo -v
		stopPrls
		sudo rm /Library/Preferences/Parallels/licenses.xml
	    remULibrary
		remSLibrary
		remCoreData
		advRestart
	    exit 0
	    ;;
	-s)
		sudo -v
		stopPrls
		if [ -f /Library/Preferences/Parallels/licenses.xml ]; then
			echo "Saving Parallels License to Desktop"
			sleep 5
			mkdir -p ~/Desktop/SavedPrlsLicense
			/usr/bin/printf "The License for Parallels is called license.xml\n\nThis file has been saved to this directory. You will be required\nto replace this file if you install Parallels onto a new system,\nor this system again.\n\nPlease consult with Parallels for further information." >> ~/Desktop/SavedPrlsLicense/ReadMe.txt
			sudo cp /Library/Preferences/Parallels/licenses.xml ~/Desktop/SavedPrlsLicense/
			sudo rm -f /Library/Preferences/Parallels/licenses.xml
		fi
		remULibrary
		remSLibrary
		remCoreData
		advRestart
		exit 0
		;;
	--help|-h)
        showHelp
	    exit 0
	    ;;
	-*)
	    echo "$program: $arg: unknown option"
	    exit 1
	    ;;
    esac
done
