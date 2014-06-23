chown -R swookiee:swookiee /opt/swookiee

if [ "$1" = "1" ]; then
  /sbin/chkconfig --add swookiee
fi

/etc/init.d/swookiee start
