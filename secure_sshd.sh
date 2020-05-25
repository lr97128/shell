#! /bin/bash
cat /var/log/secure|awk '/Failed/{print $(NF-3)}'|sort|uniq -c|awk '{print $2"="$1;}' > /root/black.txt
DEFINE="5"
for i in `cat  /root/black.txt`
do
IP=`echo $i |cut -d"=" -f 1`
NUM=`echo $i|cut -d"=" -f 2`
if [ $NUM -gt $DEFINE ]
then
grep $IP /etc/hosts.deny > /dev/null
if [ $? -gt 0 ]
then
echo "sshd:$IP:deny" >> /etc/hosts.deny
echo `date "+%Y-%m-%d %H:%M:%S"` >> /var/log/secure_sshd.log
echo ---------------------------- >> /var/log/secure_sshd.log 
echo $i >> /var/log/secure_sshd.log 
echo ---------------------------- >> /var/log/secure_sshd.log 
echo "" >> /var/log/secure_sshd.log
fi
fi
done
