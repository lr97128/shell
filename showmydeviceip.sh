#!/bin/bash
cat "/opt/apache-tomcat-7.0.67/logs/localhost_access_log.`date +%Y-%m-%d`.txt"|grep "GET /showmydiviceip/getsomepages.jsp HTTP/1.1"|tail -1|awk '{print $1}' > mydeviceip.txt
NUM=`cat mydeviceip.txt|wc -l`
if [ $NUM -eq 0 ]
then
echo "mydeviceip.txt is null"
else
IP=`cat mydeviceip.txt`
echo `date` $IP
sed -ri "s#[0-9]+.[0-9]+.[0-9]+.[0-9]+#$IP#g" /opt/apache-tomcat-7.0.67/webapps/showmydiviceip/showmydevice.jsp
fi
