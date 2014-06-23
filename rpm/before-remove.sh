/etc/init.d/swookiee stop > /tmp/lol
# >/dev/null 2>&1 || true

if [ "$1" -eq 0 ]; then
  /sbin/chkconfig --del swookiee
 
  # delete user
  getent passwd swookiee > /dev/null
  USER_EXISTS=$?

  if [ $USER_EXISTS -eq 0 ] ; then
    userdel -r swookiee
  fi

  # delete user group
  getent group swookiee > /dev/null
  GROUP_EXISTS=$?

  if [ $GROUP_EXISTS -eq 0 ]; then
    groupdel swookiee
  fi
fi
