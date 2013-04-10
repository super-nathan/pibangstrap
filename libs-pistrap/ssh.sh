#!/bin/bash
sh -l -ex - <<\EOF
rm -f /etc/ssh/ssh_host_*_key*
cat <<\RCL | tee /etc/rc.local
#!/bin/sh -e
#
# rc.local
#
# This script is executed at the end of each multiuser runlevel.
# Make sure that the script will "exit 0" on success or any other
# value on error.
#
# In order to enable or disable this script just change the execution
# bits.
#
# By default this script does nothing.

# Print the IP address
_IP=$(hostname -I) || true
if [ "$_IP" ]; then
  printf "My IP address is %s\n" "$_IP"
fi

exit 0
RCL
update-rc.d ssh disable # to be re-enabled at first boot when we regenerate ssh host keys
cat <<\EOF1 > /etc/init.d/regenerate_ssh_host_keys
#!/bin/sh
### BEGIN INIT INFO
# Provides:          regenerate_ssh_host_keys
# Required-Start:
# Required-Stop:
# Default-Start: 2
# Default-Stop:
# Short-Description: Regenerate ssh host keys
# Description:
### END INIT INFO

. /lib/lsb/init-functions

set -e

case "$1" in
  start)
    log_daemon_msg "Regenerating ssh host keys (in background)"
    nohup sh -c "yes | ssh-keygen -q -N '' -t dsa -f /etc/ssh/ssh_host_dsa_key && \
      yes | ssh-keygen -q -N '' -t rsa -f /etc/ssh/ssh_host_rsa_key && \
      yes | ssh-keygen -q -N '' -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key && \
      update-rc.d ssh enable && sync && \
      rm /etc/init.d/regenerate_ssh_host_keys && \
      update-rc.d regenerate_ssh_host_keys remove && \
      printf '\nfinished\n' && invoke-rc.d ssh start" > /var/log/regen_ssh_keys.log 2>&1 &
    log_end_msg $?
    ;;
  *)
    echo "Usage: $0 start" >&2
    exit 3
    ;;
esac
EOF1
chmod +x /etc/init.d/regenerate_ssh_host_keys
update-rc.d regenerate_ssh_host_keys start 2
EOF

sh -l -e - <<\EOF
update-alternatives --set libgksu-gconf-defaults /usr/share/libgksu/debian/gconf-defaults.libgksu-sudo
update-gconf-defaults
EOF




#extra, networking, I want it here!!!
sh -l -ex - <<\EOF
sed /etc/default/ifplugd -i -e 's/^INTERFACES.*/INTERFACES="auto"/'
sed /etc/default/ifplugd -i -e 's/^HOTPLUG_INTERFACES.*/HOTPLUG_INTERFACES="all"/'
EOF
exit 0
