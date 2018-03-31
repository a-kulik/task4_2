#!/bin/bash
x=`ps -ela | grep -w ntpd | wc -l`
if (( $x==0 ))
then
echo "NOTICE: ntp is not running"
service ntp start
fi
diff --unified=0 /etc/ntp.conf /etc/ntp.conf.bak > /dev/null
if [ $? -eq 1 ]
then
echo "NOTICE: /etc/ntp.conf was changed. Calculated diff:"
diff --unified=0 /etc/ntp.conf /etc/ntp.conf.bak 
cat /etc/ntp.conf.bak > /etc/ntp.conf
service ntp restart
fi
