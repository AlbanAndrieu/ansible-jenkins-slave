#!/bin/bash
#set -x

PRG=`basename $0`

function f_usage {
    echo "Script discovery fs";
    echo "";
    echo "Usage:";
    echo " $PRG ";
    echo "";
    exit 0;
}

if [ $# -ne 0 ]; then
    f_usage;
    exit 0;
fi

first=1;

# prepare JASON data
echo "{\"data\":[";

cat /proc/mounts | cut -f2,3 -d" " | while read line
do
    if [ -n "$line" ] ; then
        fsname=`echo "$line" | cut -f1 -d" " | grep -v "/usr/local/kzone-connector"`
        fstype=`echo "$line" | cut -f2 -d" " | grep -v "zfs"`
        if [ -n "$fsname" ] && [ -n "$fstype" ] ; then
            if [ $first -eq 0 ] ; then
                echo ",";
            fi
            first=0;
            echo "{\"{#FSNAME}\":\"$fsname\",\"{#FSTYPE}\":\"$fstype\"}";
        fi
    fi
done

echo "]}";
