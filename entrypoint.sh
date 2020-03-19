#!/bin/sh

# default user if none is set
if [ -z "$FTPUSER" ]; then
  FTPUSER="ftp|alpineftp"
fi

for i in $FTPUSER ; do
    FTPUSERNAME=$(echo $i | cut -d'|' -f1)
    FTPPASSWORD=$(echo $i | cut -d'|' -f2)
    FTPFOLDER=$(echo $i | cut -d'|' -f3)
    UID=$(echo $i | cut -d'|' -f4)

  if [ -z "$FTPFOLDER" ]; then
    FTPFOLDER="/ftp/$FTPUSERNAME"
  fi

  if [ ! -z "$UID" ]; then
    UID_OPT="-u $UID"
  fi

  echo -e "$FTPPASSWORD\n$FTPPASSWORD" | adduser -h $FTPFOLDER -s /sbin/nologin $UID_OPT $FTPUSERNAME
  mkdir -p $FTPFOLDER
  chown $FTPUSERNAME:$FTPUSERNAME $FTPFOLDER
  unset FTPUSERNAME FTPPASSWORD FTPFOLDER UID
done


if [ -z "$MIN_PORT" ]; then
  MIN_PORT=21000
fi

if [ -z "$MAX_PORT" ]; then
  MAX_PORT=21010
fi

if [ ! -z "$FTPSERVERADDRESS" ]; then
  ADDR_OPT="-opasv_address=$FTPSERVERADDRESS"
fi

# Used to run custom commands inside container
if [ ! -z "$1" ]; then
  exec "$@"
else
  exec /usr/sbin/vsftpd -opasv_min_port=$MIN_PORT -opasv_max_port=$MAX_PORT $ADDR_OPT /etc/vsftpd/vsftpd.conf
fi

