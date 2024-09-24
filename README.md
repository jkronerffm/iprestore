# iprestore
__iprestore__ is a service that keeps the ip address secure. Every _n_ seconds The scripts tests with the command `ip a` if a valid ip address exists. If not a `dhclient` will be called to restore the ip address.
# Configuration
The service can be configured from the file _/etc/iprestore.cfg_. This file contains the data
[main]
description=<the description>

[init]
wait=<time> ; this is the time in seconds the script waits between the proofs for ip a. This is commonly 15s
device=<device> ; the device to proof for ip address. This is commonly wlan0

If you have changed the file you have to restart the service with
`sudo systemctl restart iprestore`
