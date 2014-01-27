#!/bin/bash
#
# Mac OS X Parallels Removal Script v3.1.0
#
# Copyright (c) 2013-2014 Danijel James
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of
# this software and associated documentation files (the "Software"), to deal in
# the Software without restriction, including without limitation the rights to
# use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
# the Software, and to permit persons to whom the Software is furnished to do so,
# subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
# FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
# COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
# IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
# CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#
# Copyright (C) 2007-2013 Oracle Corporation
#
# Portions of this file are part of VirtualBox Open Source Edition (OSE), 
# as available from http://www.virtualbox.org. This file is free software;
# you can redistribute it and/or modify it under the terms of the GNU
# General Public License (GPL) as published by the Free Software
# Foundation, in version 2 as it comes in the "COPYING" file of the
# VirtualBox OSE distribution. VirtualBox OSE is distributed in the
# hope that it will be useful, but WITHOUT ANY WARRANTY of any kind.
#

program=`basename $0`
version="3.1.0"

# Override $PATH directory to prevent issues
export PATH="/bin:/usr/bin:/sbin:/usr/sbin:$PATH"

declare -a rm_folders
declare -a rm_files

#
# Welcome message
#
echo ""
echo "Mac OS X Remove Parallels Script v$version"
echo ""

#
# New menu layout
#
the_default_prompt=0
if test "$#" != "0"; then
    if test "$#" != "1" -o "$1" != "-s"; then
        echo "Error: Unknown argument(s): $*"
        echo ""
        echo "Usage: $program [-s]"
        echo ""
        echo "If the '-s' option is not given, the script will"
        echo "not save a copy of your 'LICENCE.xml' file."
        echo ""
        exit 4;
    fi
fi





#
# Display the files and directories that will be removed
# and get the user's consent before continuing.
#
if test -n "${my_files[*]}"  -o  -n "${my_directories[*]}"; then
    echo "The following files and directories (bundles) will be removed:"
    for file in "${my_files[@]}";       do echo "    $file"; done
    for dir  in "${my_directories[@]}"; do echo "    $dir"; done
    echo ""
fi
if 




#
# Collect KEXTs to remove.
# Note that the unload order is significant.
#
declare -a my_kexts
for kext in org.virtualbox.kext.VBoxUSB org.virtualbox.kext.VBoxNetFlt org.virtualbox.kext.VBoxNetAdp org.virtualbox.kext.VBoxDrv; do
    if /usr/sbin/kextstat -b $kext -l | grep -q $kext; then
        my_kexts+=("$kext")
    fi
done

test -d /Library/Receipts/VBoxKEXTs.pkg/           && my_directories+=("/Library/Receipts/VBoxKEXTs.pkg/")

test -f /usr/bin/VirtualBox                        && my_files+=("/usr/bin/VirtualBox")

#
# Look for running VirtualBox processes and warn the user
# if something is running. Since deleting the files of
# running processes isn't fatal as such, we will leave it
# to the user to choose whether to continue or not.
#
# Note! comm isn't supported on Tiger, so we make -c to do the stripping.
#
my_processes="`ps -axco 'pid uid command' | grep -wEe '(VirtualBox|VirtualBoxVM|VBoxManage|VBoxHeadless|vboxwebsrv|VBoxXPCOMIPCD|VBoxSVC|VBoxNetDHCP|VBoxNetNAT)' | grep -vw grep | grep -vw VirtualBox_Uninstall.tool | tr '\n' '\a'`";
if test -n "$my_processes"; then
    echo 'Warning! Found the following active VirtualBox processes:'
    echo "$my_processes" | tr '\a' '\n'
    echo ""
    echo "We recommend that you quit all VirtualBox processes before"
    echo "uninstalling the product."
    echo ""
    if test "$my_default_prompt" != "Yes"; then
        echo "Do you wish to continue none the less (Yes/No)?"
        read my_answer
        if test "$my_answer" != "Yes"  -a  "$my_answer" != "YES"  -a  "$my_answer" != "yes"; then
            echo "Aborting uninstall. (answer: '$my_answer')".
            exit 2;
        fi
        echo ""
        my_answer=""
    fi
fi




#
# Collect directories and files to remove.
# Note: Do NOT attempt adding directories or filenames with spaces!
#
declare -a my_directories
declare -a my_files

if [ $# = 0 ]
then
	echo ""
    echo "    $program Version $version"
    echo ""
    echo "    usage: $program [option]"
    echo ""
    echo "       options:"
    echo "          -r   Remove Parallels"
    echo "          -s   Save License and Remove"
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
	*|-*)
	    echo "$program: $arg: unknown option"
	    exit 1
	    ;;
    esac
done


if test "$my_rc" -eq 0; then
    echo "Successfully unloaded VirtualBox kernel extensions."
else

echo "Done."
exit 0;