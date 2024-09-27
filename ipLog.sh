#!/bin/bash


# DIRECOTIO AND IP

# ONLY IP

# ONLY DIRECTORY

# NOTING


if test -d $1

ip1=$(echo "$1" | cut -d '.' -f 1)
ip2=$(echo "$1" | cut -d '.' -f 2)
ip3=$(echo "$1" | cut -d '.' -f 3)
ip4=$(echo "$1" | cut -d '.' -f 4)

if echo "$ip1 $ip2 $ip3 $ip4" | grep -q '[a-zA-Z]'
    then
        echo "ERROR: La dirección IPv4 tiene letras"
        exit 1
fi

if  test "$ip1" -ge 0 && test "$ip1" -lt 256 &&
    test "$ip2" -ge 0 && test "$ip2" -lt 256 &&
    test "$ip3" -ge 0 && test "$ip3" -lt 256 &&
    test "$ip4" -ge 0 && test "$ip4" -lt 256
    then
        echo "Valid"
    else
        echo "Invalid"
fi
