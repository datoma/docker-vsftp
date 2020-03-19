#!/bin/sh

# default user if none is set
if [ -z "$FTP_USER" ]; then
  FTP_USER="ftp|alpineftp"
fi

for i in $FTP_USER ; do
    FTP_USER_NAME=$(echo $i | cut -d'|' -f1)
    FTP_PASSWORD=$(echo $i | cut -d'|' -f2)
    FTP_FOLDER=$(echo $i | cut -d'|' -f3)
    FTP_UID=$(echo $i | cut -d'|' -f4)

  if [ -z "$FTP_FOLDER" ]; then
    FTP_FOLDER="/ftp/$FTP_USER_NAME"
  fi

  if [ ! -z "$FTP_UID" ]; then
    FTP_UID_OPT="-u $FTP_UID"
  fi

  echo -e "$FTP_PASSWORD\n$FTP_PASSWORD" | adduser -h $FTP_FOLDER -s /sbin/nologin $FTP_UID_OPT $FTP_USER_NAME
  mkdir -p $FTP_FOLDER
  chown $FTP_USER_NAME:$FTP_USER_NAME $FTP_FOLDER
  unset FTP_USER_NAME FTP_PASSWORD FTP_FOLDER FTP_UID
done


if [ -z "$FTP_MIN_PORT" ]; then
  FTP_MIN_PORT=21000
fi

if [ -z "$FTP_MAX_PORT" ]; then
  FTP_MAX_PORT=21010
fi

if [ ! -z "$FTP_SERVER_ADDRESS" ]; then
  FTP_ADDR_OPT="-opasv_address=$FTP_SERVER_ADDRESS"
fi

# Used to run custom commands inside container
if [ ! -z "$1" ]; then
  exec "$@"
else
  exec /usr/sbin/vsftpd -opasv_min_port=$FTP_MIN_PORT -opasv_max_port=$FTP_MAX_PORT $FTP_ADDR_OPT /etc/vsftpd/vsftpd.conf
fi

