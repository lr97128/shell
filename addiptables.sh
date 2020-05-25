#/bin/sh
cat /var/log/secure | grep "refused connect from" |awk '{print $(NF-1)}'| uniq -c | awk '{print $2"="$1}' > /root/drop.txt
DEFINE="5"
for i in `cat /root/drop.txt`
do
IP=`echo $i | cut -d"=" -f1`
NUM=`echo $i | cut -d"=" -f2`
if [ $NUM -ge $DEFINE ]
then
HASIT=`iptables -nvL | grep $IP | wc -l`
if [ $HASIT -eq 0 ]
then
iptables -I INPUT 1 -p all -s $IP/32 -j DROP >> /var/log/addiptables.log 2>&1
iptables -I INPUT 1 -p all -s $IP/32 -j LOG --log-level 5  --log-prefix "INPUT" --log-ip-options --log-tcp-sequence >> /var/log/addiptables.log 2>&1
/usr/libexec/iptables/iptables.init save
fi
fi
done
