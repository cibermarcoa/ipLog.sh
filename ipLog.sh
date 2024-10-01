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
            return 1
        else
            echo "Dirección IP invalida"
            exit 1
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

# ONLY DIRECTORY OR IP
if test $# = 1
    then
        if test -d $1
            # IS DIRECTORY
            then
                IP=$(grep -oE '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' /var/log/auth.log | tail -n 1)
                echo Buscando la IP: $IP en el directorio $1
                logsFiles=$(find $1 -name "*.log")
                for LOG in $logsFiles
                do
                    coincidences=$(grep -o $IP $LOG)
                    for CON in $coincidences
                    do
                        echo $LOG:$IP
                    done
                done
                exit 0
            # IS IP
            else ip_checker $1
                echo "Buscando "$1" en /var/log/auth.log"
                echo $(grep -o "$1" /var/log/auth.log | wc -l) "$1" # He cambiado la ruta
        fi
fi

# DIRECOTIO AND IP (esto esta bien y revisado pero el bucle se pilla)
if test -d $1
then
    ip_checker $2
    echo $2 es una IP y $1 un directorio. Buscamos dentro:
    for LOG in $(find $1 -type f -name "*.log" 2>/dev/null)
    do
        grep -H "$2" "$LOG" 2>/dev/null
    done
fi

exit 0
