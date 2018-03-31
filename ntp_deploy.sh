#!/bin/bash
apt-get install ntp -y
sed -i '/^pool/d' /etc/ntp.conf
echo "server ua.pool.ntp.org" >> /etc/ntp.conf
cp /etc/ntp.conf /etc/ntp.conf.bak
service ntp restart
dir_pwd=$(dirname "$0")
dir_pwd=$(cd "$dir_pwd" && pwd)
echo_var="* *    * * *   root	${dir_pwd}/ntp_verify.sh"
if (( $(cat /etc/crontab | grep -w "${dir_pwd}/ntp_verify.sh" | wc -l)==0 ))
then
echo "$echo_var" >> /etc/crontab
fi
