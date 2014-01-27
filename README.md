Remove Parallels from OS X
==========================
  
**sudo rm -rf : for parallels**
  
------

Formerely known as "Remove Parallels All Versions". Renamed because I fixed up the original script, compiled an AppleScript that does the hard work for you, and then 
bundled it into a self-contained Mac OSX app.  Now has a feature that will save your **Parallels** licence to the Desktop in a folder with a ReadMe file so you don't forget what it is.

#### Installation #
Download the `Remove Parallels` script to the `/usr/bin` directory _(requires **cURL** and **sudo**)_:
``` bash
sudo curl "https://raw.github.com/danijeljames/remparallels/master/remprls.sh" -o "/usr/bin/remprls" && sudo chmod a+x /usr/bin/remprls
```
Run script from Terminal:
``` bash
remprls [-s | -r]
```
Download the **Remove Parallels Mac GUI** application instead:  [`Remove_Parallels-2.1.1.zip`](http://snipurl.com/280pjei) 

#### Usage #
| remprls | [-h]&nbsp;&nbsp;&nbsp;[-r]&nbsp;&nbsp;&nbsp;[-s] |
|---------|---------------------|
| `-r` | Totally removes Parallels including license |
| `-s` | Saves licence to Desktop and removes Parallels |

#### Contribution #
- Log a [bug report](https://github.com/danijeljames/remparallels/issues/new)
- Send tweet to [@danijeljames](https://twitter.com/danijeljames) #RemPrls

#### Checksums #
**Download:** [`Remove_Parallels-2.1.1.zip`](http://snipurl.com/280pjei)  
**SHA1:** `e1d9c682c7fc45030c0b0e8f625ddec5c90708c5`  
**MD5:** `7ee5205d0f27ca34bee020b0d87963c2`




