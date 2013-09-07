for pid in $(ps aux | grep "Parallels Desktop.app" | awk '{print $2}'); do echo kill -KILL $pid; done
for kext in $(kextstat | grep parallels | awk '{print $6}'); do kextunload $kext; done
mkdir ~/Desktop/Saved\ Parallels\ Licence
mv /Library/Preferences/Parallels/licences.xml ~/Desktop/Saved\ Parallels\ Licence/licences.xml
curl https://raw.github.com/danijeljames/remparallels/master/Removed-Licence.txt -o ~/Desktop/Saved\ Parallels\ Licence/Removed-Licence.txt
rm -rf /Application/Parallels*
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
rm -rf /Users/Shared/Parallels/
rm -rf /Library/Logs/parallels*
rm -rf /Library/Logs/Parallels*
rm -rf /Library/logs/parallels.log
rm -rf /Library/Preferences/com.parallels*
rm -rf /Library/Preferences/Parallels/*
rm -rf /Library/Preferences/Parallels
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
rm -rf /System/Library/Extensions/prl*
periodic daily weekly monthly




