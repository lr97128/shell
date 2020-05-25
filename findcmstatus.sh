#! /bin/bash
clock
DeviceIP="10.255.6.123"
DeviceComm="whcccpublic"
SNMPVer="2c"
CMMAC_OID="1.3.6.1.2.1.10.127.1.3.3.1.2"
CMIP_OID="1.3.6.1.2.1.10.127.1.3.3.1.3"
CM_MACS=`snmpwalk -c $DeviceComm $DeviceIP -v $SNMPVer "$CMMAC_OID" | awk -F'.' '{print $8}' | awk -F' ' '{print $1"="$4$5"."$6$7"."$8$9}'` ; snmpwalk -c $DeviceComm $DeviceIP -v $SNMPVer "$CMIP_OID" | awk -F'.' '{print $8"."$9"."$10"."$11}' | awk -F':' '{print $1"="$2}' | awk -F'=' '{print $1"="$3}' | awk -F' ' '{print $1"="$3}' > /opt/cmip.log
clock
FLAG="0"
#CM_MACS=`cat /opt/cmmac.log`
for i in $CM_MACS 
do
CM_INDEX=`echo $i | awk -F= '{print $1}'`
CM_MAC=`echo $i | awk -F= '{print $2}'`
echo $CM_MAC | egrep \".*\.\.  > /dev/null 2>&1
if [ $? -eq 0 ]
then
continue
fi
CM_IP=`cat /opt/cmip.log | grep $CM_INDEX | awk -F= '{print $2}' | awk -F' ' '{print $1}'` > /dev/null 2>&1
if [ $? -eq 0 ]
then
if [ $FLAG -eq 0 ]
then
echo index "          " cm_mac "          " cm_ip > /opt/cmstatus.log
echo $CM_INDEX "    " $CM_MAC "    " $CM_IP >> /opt/cmstatus.log
FLAG=1
else
echo $CM_INDEX "    " $CM_MAC "    " $CM_IP >> /opt/cmstatus.log
fi
else
CM_IP="NULL"
if [ $FLAG -eq 0 ]
then
echo index "          " cm_mac "          " cm_ip > /opt/cmstatus.log
echo $CM_INDEX "    " $CM_MAC "    " $CM_IP >> /opt/cmstatus.log
FLAG=1
else
echo $CM_INDEX "    " $CM_MAC "    " $CM_IP >> /opt/cmstatus.log
fi
fi
done
clock
