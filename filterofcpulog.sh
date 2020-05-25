#!/bin/bash
python /root/cpuusage.py > /root/cpuusage.tmp
myusage=`awk -F [' ''%'] 'NR==3{print $6}' /root/cpuusage.tmp`
if [ ${myusage} -gt 60 ]
then
mydate=`awk 'NR==1{print $1}' /root/cpuusage.tmp`
mytime=`awk 'NR==1{print $2}' /root/cpuusage.tmp`
ls -l /var/log/cpuusage/${mydate} > /dev/null
if [ $? -gt 0 ]
then
mkdir /var/log/cpuusage/${mydate} 
fi
awk '{if(NR==1){print}if(NR==3){print $1,$2,$3,$4,$5,$6}if(NR>=4 && NR<=9){for(i=5;i<=NF;i++){printf "%-8s", $i}{printf "\n"}}}' /root/cpuusage.tmp > /root/errmsg.txt
./senderrormsg.py
mv /root/cpuusage.tmp /var/log/cpuusage/${mydate}/${myusage}-${mytime}.log
fi
