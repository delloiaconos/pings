#!/bin/bash

# Ping multiple ips by Salvatore Dello Iacono [delloiaconos@gmail.com]
# Example of Usage:
#      pings 192.168.1.{1,2}
#   OR
#      pings 192.168.1.{1..254}
#   OR
#      pings 192.168.{1,2}.{1..254}


#valid_ip function was taken from:
#Validating an IP Address in a Bash Script
#by Mitch Frazier on June 26, 2008
function valid_ip()
{
    local  ip=$1
    local  stat=1

    if [[ $ip =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
        OIFS=$IFS
        IFS='.'
        ip=($ip)
        IFS=$OIFS
        [[ ${ip[0]} -le 255 && ${ip[1]} -le 255 \
            && ${ip[2]} -le 255 && ${ip[3]} -le 255 ]]
        stat=$?
    fi
    return $stat
}

#Trapping ctrl-c
trap exit INT

for ip in $@; do
	if (valid_ip $ip); then
		ping -c 1 $ip
	fi;
done;
