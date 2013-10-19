Remove Parallels from OS X
==========================
  
**sudo rm -rf : for parallels**
  
------

Formerly known as "Remove Parallels All Versions". 

Formerely known as "Remove Parallels All Versions". Renamed because I fixed up the original script, compiled an AppleScript that does the hard work for you, and then bundled
 it into a self-contained Mac OSX app.  Now has a feature that will save your **Parallels** licence to the desktop in a folder with a Readme file so you don't forget what it is.




man2pdf will quickly pipe any [`manpage`](http://en.wikipedia.org/wiki/Man_page) to Preview to open up so you can save it as a `PDF` to make life easier to read it. Simply call the manpage you want as the first positional parameter after `man2pdf` and it will do the rest for you. No hassles!  

#### Installation #
Download the man2pdf script to the `/usr/bin` directory _(requires **cURL** and **sudo**)_:
``` bash
sudo curl "https://raw.github.com/danijeljames/man2pdf/master/man2pdf.sh" -o "/usr/bin/man2pdf.sh" && sudo chmod +x /usr/bin/man2pdf.sh
```
Install the man page for man2pdf:
``` bash
sudo man2pdf -i
```
#### Usage #
| man2pdf | [-h]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[manpage]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[-i] |
|---------|---------------------|
| `-h` | Displays the help file |
| `-i` | Installs the manpage for man2pdf _(requires sudo)_ |
| `manpage` | `man2pdf echo` would get the `echo` manpage and pipe it to Preview |

#### Contribution #
- Log a [bug report](https://github.com/danijeljames/man2pdf/issues/new)
- Send tweet to [@danijeljames](https://twitter.com/danijeljames)