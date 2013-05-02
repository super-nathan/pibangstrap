pibangstrap
=======

ABOUT:
pibangstrap - Bootstraps your own PiBang install.

INSTALL:
With the addition of libraries, this software must be installed with dpkg and ran like a normal program.
From the pistrap folder run: 

    dpkg-buildpackage 
    
to make a package, now install with

    cd ../ && sudo dpkg -i PISTRABPACKAGENAME.deb
    
now you can run it with

    sudo pibangstrap

CREDITS:
First based on work by Klaus M Pfeiffer <klaus.m.pfeiffer@kmp.or.at> at http://blog.kmp.or.at/2012/05/build-your-own-raspberry-pi-image/.
James Bennet <github@james-bennet.com> added a lot more customisability, fixed lots of bugs, and added a UI.
Nathan Weber <supernathansunshine@gmaill.com> added many elements from Alex Bradbury <asb@asbradbury.org> and his work with "Spindle" as well as doubling the size of this program, so instead of creating a minimal image, it creates a full PiBang install.

USAGE:
The program is wizard driven. Just follow the directions and it's easy.
* This program makes an image, which you can DD yourself later to your SD-Card. The image can be found in your working folder
* The location you use as a buildroot will be owned by root after creation. This should be an (empty) directory where you want the new system to be populated. This directory will reflect the root filesystem of the new system. Note that the host system is not affected in any way, and all modifications are restricted to the directory you have chosen.
* As of now it is not playing nice and unmounting itelf, you will need to unmount buildroot manually, or reboot.

TIPS:
* There is NO DEFAULT USER OR PASSWORD! You will create a user upon first boot, and you can make a root user with 

    sudo passwd root
    
* We install NTP as the date and time will be wrong, due to no RTC being on the board. We also need this and the SSL certificates, so we can checkout the firmware from github.
* You need to have superuser rights to use this tool because debootstrap will create device nodes (using mknod) as well as chroot into the newly *created system.
* It *should* work on non-debian systems that have debootstrap. I have heard you can install debootstrap on Fedora, Arch Linux etc...  Our apt-get's are done inside the debian chroots now, which is fine.
* Everything is logged to /var/log/pibangstrap.log
