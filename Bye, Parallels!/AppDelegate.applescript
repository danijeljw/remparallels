--
--  AppDelegate.applescript
--  Bye, Parallels!
--
--  Created by Danijel James on 10/11/2013.
--  Copyright (c) 2013 Danijel James. All rights reserved.
--
--  Permission is hereby granted, free of charge, to any person obtaining a copy of
--  this software and associated documentation files (the "Software"), to deal in
--  the Software without restriction, including without limitation the rights to
--  use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
--  the Software, and to permit persons to whom the Software is furnished to do so,
--  subject to the following conditions:
--
--  The above copyright notice and this permission notice shall be included in all
--  copies or substantial portions of the Software.
--
--  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
--  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
--  FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
--  COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
--  IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
--  CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
--

script AppDelegate
	property parent : class "NSObject"
	
	on applicationWillFinishLaunching_(aNotification)
	end applicationWillFinishLaunching_
    
    on ButtonHandlerResetParallels_(sender)
        set versionNum to "1.0.0"
        set title to "Reset Parallels Trial " & versionNum
        display dialog "Reset Trial Period?" with title title buttons {"Yes", "No"}
        if result = {button returned:"Yes"}
            do shell script "rm -rf /Library/Preferences/Parallels/licenses.xml" with administrator privileges
        end if
        display dialog "Parallels Trial has been reset." with title "Reset Complete" buttons {"OK"} default button 1 with icon note giving up after 10
    end ButtonHandlerResetParallels_
    
    on ButtonHandlerRemoveParallels_(sender)
        -- Option to keep the License XML file
        display dialog "Do you want to save your current Parallels license file?" with title "Save License?" buttons {"Yes", "No"} default button 1
        if result = {button returned:"Yes"} then
            tell application "Finder"
                set p to path to desktop
                make new folder at p with properties {name:"Saved Parallels License"}
            end tell
            do shell script "cp /Library/Preferences/Parallels/licenses.xml ~/Desktop/Saved\\ Parallels\\ License/licenses.xml" with administrator privileges
        end if
        -- kill Parallels
        do shell script "for pid in $(ps aux | grep \"Parallels Desktop.app\" | awk '{print $2}'); do echo kill -KILL $pid; done" with administrator privileges
        do shell script "for kext in $(kextstat | grep parallels | awk '{print $6}'); do kextunload $kext; done" with administrator privileges
        -- Remove License XML file
        do shell script "rm /Library/Preferences/Parallels/licenses.xml" with administrator privileges
        -- remove User Library data
        do shell script "rm -rf ~/Library/Preferences/com.parallels.*" with administrator privileges
        do shell script "rm -rf ~/Library/Preferences/Parallels/*" with administrator privileges
        do shell script "rm -rf ~/Library/Preferences/Parallels*" with administrator privileges
        do shell script "rm -rf ~/Library/Preferences/parallels/*" with administrator privileges
        do shell script "rm -rf ~/Library/Preferences/parallels*" with administrator privileges
        do shell script "rm -rf ~/Library/Parallels/" with administrator privileges
        do shell script "rm -rf ~/Library/Logs/Parallels*" with administrator privileges
        do shell script "rm -rf ~/Library/Logs/parallels*" with administrator privileges
        do shell script "rm -rf ~/Library/Saved\\ Application\\ State/com.parallels.*/*" with administrator privileges
        do shell script "rm -rf ~/Library/Saved\\ Application\\ State/com.parallels.*" with administrator privileges
        -- remove System Library Data
        do shell script "rm -rf /Library/Logs/parallels*" with administrator privileges
        do shell script "rm -rf /Library/Logs/Parallels*" with administrator privileges
        do shell script "rm -rf /Library/logs/parallels.log" with administrator privileges
        do shell script "rm -rf /Library/Preferences/com.parallels*" with administrator privileges
        do shell script "rm -rf /Library/Preferences/Parallels/*" with administrator privileges
        do shell script "rm -rf /Library/Preferences/Parallels" with administrator privileges
        -- remove Core Application Data
        do shell script "rm -rf /private/var/db/parallels/stats/*" with administrator privileges
        do shell script "rm -rf /private/var/db/Parallels/stats/*" with administrator privileges
        do shell script "rm -rf /private/var/db/parallels/stats" with administrator privileges
        do shell script "rm -rf /private/var/db/Parallels/stats" with administrator privileges
        do shell script "rm -rf /private/var/db/parallels" with administrator privileges
        do shell script "rm -rf /private/var/.parallels_swap" with administrator privileges
        do shell script "rm -rf /private/var/.Parallels_swap" with administrator privileges
        do shell script "rm -rf /private/var/db/receipts/'com.parallels*'" with administrator privileges
        do shell script "rm -rf /private/var/root/library/preferences/com.parallels.desktop.plist" with administrator privileges
        do shell script "rm -rf /private/tmp/qtsingleapp-*-lockfile" with administrator privileges
        do shell script "rm -rf /private/tmp/com.apple.installer*/*" with administrator privileges
        do shell script "rm -rf /private/tmp/com.apple.installer*" with administrator privileges
        do shell script "rm -rf /System/Library/Extensions/prl*" with administrator privileges
        -- cleanup
        do shell script "periodic daily weekly monthly" with administrator privileges
    end ButtonHandlerRemoveParallels_
	
    -- Show help dialog
    on ButtonHandlerShowHelp_(sender)
        display dialog "Bye, Parallels! is the simple and effective way to remove Parallels from your Mac system without any hassle. It also lets you just reset the trial period if you aren't ready to purchase. Please visit my website to read about my other projects." with title "Help" with icon note buttons {"Website","OK"} default button 2
        if result = {button returned:"Website"} then
            open location "http://danijelj.com/projects/"
        end if
    end ButtonHandlerShowHelp_
    
    -- Bitcoin donation
    on ButtonHandlerBitcoinDonation_(sender)
        open location "https://coinbase.com/checkouts/21ed006ac313d994a184bba489d5e70d"
    end ButtonHandlerBitcoinDonation_
    
    -- Litecoin donation
    on ButtonHandlerLitecoinDonation_(sender)
        display dialog "Litecoin donation feature was not complete\nat the time of making this application. This\nfeature will be implemented in the next update." with title "Litecoin Donations" buttons {"OK"}
    end ButtonHandlerLitecoinDonation_
    
    -- GooglePlay Donation Box
    on ButtonHandlerGooglePlayDonate_(sender)
        display dialog "Google Play donation feature was not complete\nat the time of making this application. This\nfeature will be implemented in the next update." with title "Google Play Donations" buttons {"OK"}
    end ButtonHandlerGooglePlayDonate_
    
	on applicationShouldTerminate_(sender)
		return current application's NSTerminateNow
	end applicationShouldTerminate_
	
end script