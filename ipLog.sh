#!/bin/bash

# Almacena el argumento en una variable



ip1=$(echo "$1" | cut -d '.' -f 1)
ip2=$(echo "$1" | cut -d '.' -f 2)
ip3=$(echo "$1" | cut -d '.' -f 3)
ip4=$(echo "$1" | cut -d '.' -f 4)




if echo "$ip1 $ip2 $ip3 $ip4" | grep -q '[a-zA-Z]'
    then
        echo "ERROR: La dirección IPv4 tiene letras"
        exit 1
fi


if  [ "$ip1" -ge 0 ] && [ "$ip1" -lt 256 ] &&
    [ "$ip2" -ge 0 ] && [ "$ip2" -lt 256 ] &&
    [ "$ip3" -ge 0 ] && [ "$ip3" -lt 256 ] &&
    [ "$ip4" -ge 0 ] && [ "$ip4" -lt 256 ]
    then
        echo "Valid"
    else
        echo "Invalid"
fi

