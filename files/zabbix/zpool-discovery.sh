#!/bin/bash
#set -x

PRG=`basename $0`

function f_usage {
    echo "Script discovery zpools";
    echo "";
    echo "Usage:";
    echo " $PRG ";
    echo "";
    echo " REMARK: This script works only on Solaris OS or Linux with ZFS."
    exit 0;
}


if [ $# -ne 0 ]; then
    f_usage;
    exit 0;
fi

first=1;
fstype="zpool";

# prepare JASON data
echo "{\"data\":[";

zpool list -H | while read line
do
    if [ -n "$line" ] ; then
        fsname=`echo "$line" | cut -f1`
        if [ -n "$fsname" ] ; then
            if [ $first -eq 0 ] ; then
                echo ",";
            fi
            first=0;
            echo "{\"{#FSNAME}\":\"$fsname\",\"{#FSTYPE}\":\"$fstype\"}";
        fi
    fi
done

echo "]}";
