#!/bin/bash
ps -ef | grep firefox | grep -v grep | grep -v /bin/bash | awk '{print $2}' > /root/killprocess.txt
for i in `cat killprocess.txt`
do
kill -9 $i
done
