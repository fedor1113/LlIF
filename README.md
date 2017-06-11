# LlIF - Linux :heart: Interactive fiction
This is a small script that adds support for various interactive story formats in Linux systems, i.e it installs their MIME-types, adds missing icons, installs basic software, adds it to launchers.

It currently works for the following formats:
* Adrift
* Alan
* Blorbs (various)
* Glulx
* TADS
* TADS 3
* Z-code

It attempts to install (if receives "yes" when asking) the following packages from Debian repositories with apt (so it makes perfect sense to answer "no" if your distro is not Debian-based or you have compiled newer versions from source yourself):
* Gargoyle multi-format IF interpreter (gargoyle-free package) - seems to be an older version
* Zoom IF interpreter (zoom-player package) - previous version currently
* bsd-games package (has e.g. adventure game)

The artwork (icon for formats) is based on the icon for epubs from [Papirus icon theme for Linux](https://github.com/PapirusDevelopmentTeam/papirus-icon-theme). The Zoom icon has a 4-point compass rose (with directions) and a big &quot;Z&quot; added to it. The formats icon has a command prompt symbol (&quot;>_&quot;) added to it.

# Rationale
All right, so why might anyone need this?

Currently (as of June 2017), IMHO, there is no beautiful &quot;one-click&quot; solution that allows to play all IF games and adds file system support for them in Linux. You'll have to do some tweaking. However, this tiny script does all the trivial things. After using it on a Linux system an IF enthusiast won't have to do much. It becomes much easier to manage large collections of text-quests when you can open them in Gargoyle from the file manager.  The lack of file icons used to be a frustrating aspect of playing IF, too - but no longer)

# LICENSE
The script itself (with appropriate helper files) is licensed under MIT (see LICENSE file). The icons are under GNU LGPL v3.0 (modifications to the original are described here and in the commits; see LICENSE file in the Icons subfolder).
