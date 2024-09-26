#!/bin/bash
echo start iprestore
wait=$(/usr/local/bin/cfg_parser.py /etc/iprestore.cfg init wait)
device=$(/usr/local/bin/cfg_parser.py /etc/iprestore.cfg init device)
echo "lookup for device ${device} for validity"
echo "wait time is ${wait} seconds"
echo run loop to check if ip is present
while true
do
	ip=`ip -br a s $device | grep -E '([0-9]{1,3}(\.[0-9]{1,3}){3})' | tr -s ' ' | cut -d ' ' -f 3 | cut -d '/' -f 1`
	if [ -z "$ip" ]
	then
		echo "no ip address found for $device. Call dhclient."
		dhclient
	fi
	sleep $wait
done
