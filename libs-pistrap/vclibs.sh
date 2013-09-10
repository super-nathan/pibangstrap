#!/bin/sh
#
# this script updates ld to recognize the videocore libraries for the
#  raspberry pi on Pibang
#


# create vc.conf
touch /etc/ld.so.conf.d/vc.conf

# add necessary lines to vc.conf
echo "# this is the default directory for the Pi's videocore libraries" >> /etc/ld.so.conf.d/vc.conf
echo '/opt/vc/lib' >> /etc/ld.so.conf.d/vc.conf

# reconfigure ld so it knows to look in the new place
ldconfig
