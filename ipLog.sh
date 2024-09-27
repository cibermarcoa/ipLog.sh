#!/bin/bash

#!/bin/bash

ip_checker() {
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
}

# EXCEDEED ARGUMENTS
if test $# -gt 2
    then
        echo "ERROR: Argumentos innecesarios. La llamada debe de ser así: ./ipLog.sh [<path>] [<ip>]"
        exit 1
fi

# NOTING
if test $# = 0
    then
        tail -n 100 "/var/log/auth.log"
        exit 0
fi
# /var/log/auth.log

# ONLY DIRECTORY OR IP
"""if test $# = 1
then
    if test -d $1
        # IS DIRECTORY
        then

        # IS IP
        else

    fi
fi"""
# DIRECOTIO AND IP
if test -d $1 && ip_checker $2
then
    echo $2 es una IP y $1 un directorio. Buscamos dentro:
    logsFiles=$(find $1 -name "*.log")
    for LOG in $logsFiles
    do
        grep $2 $LOG
    done
fi
