#!/bin/bash
#通过for循环将tftp服务器都读入进来
for i in `cat /srccode/tftp-list.txt`
do
echo "===============start====================" >> /var/log/reloadtftp.log 2>&1
echo `date "+%Y-%m-%d %H:%M:%S"` >> /var/log/reloadtftp.log 2>&1
IP=$i
#将IP地址作为参数，运行重启tftp服务的脚本
/srccode/reloadtftp.sh $IP >> /var/log/reloadtftp.log 2>&1
echo "===============end====================" >> /var/log/reloadtftp.log 2>&1
echo `date "+%Y-%m-%d %H:%M:%S"` >> /var/log/reloadtftp.log 2>&1
done
