#!/bin/bash
sh -l -e - <<\EOF
cat <<EOF2 > /etc/modprobe.d/raspi-blacklist.conf
# blacklist spi and i2c by default (many users don't need them)

blacklist spi-bcm2708
blacklist i2c-bcm2708
EOF2
cat <<EOF3 > /etc/modprobe.d/ipv6.conf
# Don't load ipv6 by default
alias net-pf-10 off
#alias ipv6 off
EOF3
EOF
exit 0

