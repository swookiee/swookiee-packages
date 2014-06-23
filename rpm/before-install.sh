# make sure swookiee is not running already
test -f /etc/init.d/swookiee && /etc/init.d/swookiee status | grep "started" && /etc/init.d/swookiee stop > /dev/null

# check for user
getent passwd swookiee > /dev/null
USER_EXISTS=$?

# create swookiee user
if [ $USER_EXISTS -gt 1 ]; then
  useradd -r -U -d /opt/swookiee \
    -s /sbin/nologin -c "swookiee" swookiee
fi

