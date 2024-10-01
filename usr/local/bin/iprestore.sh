#!/bin/bash
echo start iprestore
wait=$(/usr/local/bin/cfg_parser.py /etc/iprestore.cfg init wait)
device=$(/usr/local/bin/cfg_parser.py /etc/iprestore.cfg init device)
echo "lookup for device ${device} for validity"
echo "wait time is ${wait} seconds"
echo run loop to check if ip is present
while true
do
	sleep $wait
	ip=`ip -br a s $device | grep -E '([0-9]{1,3}(\.[0-9]{1,3}){3})' | tr -s ' ' | cut -d ' ' -f 3 | cut -d '/' -f 1`
	if [ -z "$ip" ]
	then
		echo "no ip address found for $device. Call dhclient."
		dhclient
	fi
	WLAN_GW=$(ip route show 0.0.0.0/0 dev "wlan0" | cut -d' ' -f3)
	PING_TARGET="${PING_TARGET:-$WLAN_GW}"
	if ping -i5 -c10 "$PING_TARGET" > /dev/null
	then
		continue
	fi
	echo "$PING_TARGET is not reachable."
	if sudo iw dev wlan0 get power_save | grep -c -i ": on"
	then
		echo "disable power_save"
		sudo iw dev wlan0 set power_save off
		if ping -i5 -c10 "$PING_TARGET" > /dev/null
		then
			continue
		fi
	fi
	if [ -x /usr/bin/nmcli ]
	then
		echo "restart NetworkManager using nmcli"
		sudo nmcli device down wlan0
		sudo pkill dhclient
		sleep 10
		sudo nmcli device up wlan0
	fi
	if ping -i5 -c10 $PING_TARGET > /dev/null
	then
		continue
	fi
	echo "restart service networking"
	sudo systemctl stop networking
	sleep 10
	sudo systemctl start networking
done
