# iprestore
__iprestore__ is a service that keeps the ip address secure. Every _n_ seconds The scripts tests with the command `ip a` if a valid ip address exists. If not a `dhclient` will be called to restore the ip address.
