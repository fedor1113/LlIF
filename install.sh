#!/bin/bash

#
# Install common interactive fiction MIME-types for the system
#

# Blorb (see https://en.wikipedia.org/wiki/Blorb)
xdg-mime install MIME-types/x-blorb.xml
#Note: Glulx and Z-machine specific blorbs are still blorbs,
# and so they are appropriately associated

# Glulx (see https://en.wikipedia.org/wiki/Glulx)
xdg-mime install MIME-types/x-glulx.xml

# Z-code (see https://en.wikipedia.org/wiki/Z-machine)
xdg-mime install MIME-types/x-z-code.xml
#Note: ".zip" files are out of fashion nowadays (why? - I wonder)
#and so are not associated with Z-code by this script.

# Alan (https://www.alanif.se/)
xdg-mime install MIME-types/x-alan.xml

# TADS (https://en.wikipedia.org/wiki/TADS/)
xdg-mime install MIME-types/x-tads.xml

# TADS 3
xdg-mime install MIME-types/x-t3vm-image.xml

# Adrift (https://en.wikipedia.org/wiki/ADRIFT)
xdg-mime install MIME-types/x-adrift.xml

echo "Installed MIME-types for common story file formats."

#
# Install icons (there is one exclusive icon made specifically for this task)
#

#Blorb
sudo cp Icons/IF.svg /usr/share/icons/hicolor/scalable/mimetypes/application-x-blorb.svg

#Glulx
sudo cp Icons/IF.svg /usr/share/icons/hicolor/scalable/mimetypes/application-x-glulx.svg

#Z-code
sudo cp Icons/IF.svg /usr/share/icons/hicolor/scalable/mimetypes/application-x-zmachine.svg

#Alan
sudo cp Icons/IF.svg /usr/share/icons/hicolor/scalable/mimetypes/application-x-alan.svg

#TADS
sudo cp Icons/IF.svg /usr/share/icons/hicolor/scalable/mimetypes/application-x-tads.svg

#TADS 3
sudo cp Icons/IF.svg /usr/share/icons/hicolor/scalable/mimetypes/application-x-t3vm-image.svg

#Adrift
sudo cp Icons/IF.svg /usr/share/icons/hicolor/scalable/mimetypes/application-x-adrift.svg

gtk-update-icon-cache

echo "Installed icons for common story file formats."

#
# Software
#

read -p "Would you like to install story file interpreters? (Ubuntu-based distro required - installs old default versions with apt) [yes/no] " -r REPLY
echo
if [[ $REPLY =~ ^[Yy]$ ]];
then
    sudo apt install frotz gargoyle-free bsdgames instead zoom-player
    echo "Installed frotz, gargoyle-free, bsdgames, zoom-player and instead packages."
    echo "Warning: Zoom from zoom-player package (the one this script installs) is depricated. Replace it with a new version (precompiled by the author of this script?"
    read -p "[yes/no] "
    if [[ $REPLY =~ ^[Yy]$ ]];
    then
        echo "No precompiled version is ready yet."
    fi
fi

echo "To play Interactive fiction games you will need Gargoyle (http://ccxvii.net/gargoyle/). You could also use Zoom (http://logicalshift.co.uk/unix/zoom/)."
echo "Those packages were installed to your system if you typed 'yes' at the question above. If not, install them (build from source or find precompiled binaries in your repo or their downloads page) and then come back here to do some more tweaking."

read -p "Proceed with tweaking (associating MIME-types with applications, adding Zoom to app menu, adding config files and the like)? " -r REPLY
echo
if [[ $REPLY =~ ^[Yy]$ ]];
then
    # Zoom tweaks
    sudo -H cp zoom.desktop /usr/share/applications/zoom.desktop
    xdg-desktop-menu install --novendor /usr/share/applications/zoom.desktop
    #sudo echo "MimeType=application-zcode;application-glulx;application-blorb" >> /usr/share/applications/gargoyle.desktop
    
    sudo cp Icons/Zoom.svg /usr/share/icons/hicolor/scalable/apps/Zoom.svg
    echo "Added an SVG icon for Zoom. (not too good)"
    sudo cp Config/zoomrc $HOME/.zoomrc
    echo "Copied configuration file for Zoom .zoomrc in your home directory"
    echo "You can change settings there later if you like."
    echo "It has a default games and saves directory entries that will be the ones you choose here"
    
    # Gargoyle tweaks
    xdg-mime default /usr/share/applications/gargoyle.desktop application/x-zmachine application/x-glulx application/x-blorb application/x-alan application/x-tads application/x-adrift
    #sudo -H xdg-mime default /usr/share/applications/gargoyle.desktop application-zcode application-glulx application-blorb
    echo "Made Gargoyle the default application for story files."
    echo "The font in Gargoyle might be tiny or you might not like it."
    echo "Gargoyle has configuration files to change it."
    echo "This script creates a configuration file right in the directory for interactive fiction of your choice. Put your IF games there for it to be applied. "
    echo "Please choose your interactive fiction directory location..."
    echo "Option 1: ~/Games (default)"
    echo "Option 2: ~/Games/Interactive_fiction"
    echo "Option 3: ~/... (your choice)"
    read -p "[1/2/home subdirectory]: " -r REPLY
    if [[ $REPLY = "1" ]]; then
        mkdir $HOME/Games
        games=$HOME/Games
    elif [[ $REPLY = "2" ]]; then
        mkdir "$HOME/Games/Interactive_fiction"
        games="$HOME/Games/Interactive_fiction"
    else
        mkdir $HOME/$REPLY
        games="$HOME/$REPLY"
    fi
    
    head --lines=24 Config/zoomrc > $HOME/.zoomrc
    echo 'gamedir "$games"' >> $HOME/.zoomrc
    echo 'savedir "$games/saves"' >> $HOME/.zoomrc
    echo "}" >> $HOME/.zoomrc
    echo "" >> $HOME/.zoomrc
    echo "Updated ~/.zoomrc with current games directory"
    
    cp Config/garglk.ini $games/garglk.ini
    echo "Keep changing 'leading' and 'baseline' properties until you are satisfied with the result."
    echo "Note that this only affects file that are in the same folder with the ini file. If you wish your changes to apply system-wide, please edit /etc/garglk.ini"
    echo "Press ENTER to start editing your Gargoyle config... "
    nano $games/garglk.ini
fi

