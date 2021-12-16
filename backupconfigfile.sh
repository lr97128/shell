#!/bin/bash


deviceFile="/root/shell-src/devices"
PORT="2222"
PATH="/usr/local/sbin:/usr/sbin:/sbin:/usr/local/bin:/usr/bin:/bin"
PASSWORD="2020@P@\$\$w0rd*IK<9ol."
BACKUPDATE=$(date +%Y-%m-%d)

for dev in $(cat ${deviceFile})
do {
  IPADDRESS=$(echo ${dev} | awk -F: '{print $1}')
  DEVICENAME=$(echo ${dev} | awk -F: '{print $2}')
  echo "It's now to backup ${DEVICENAME}"
  expect -f /root/shell-src/expect.sh ${PORT} ${IPADDRESS} ${PASSWORD} ${DEVICENAME} ${BACKUPDATE}
} &
done



-----------------------------------------------
ip:hostname
