#!/bin/bash
#set -x

PRG=`basename $0`

function f_usage {
    echo "Script shows size of filesystem for zpool.";
    echo "";
    echo "Usage:";
    echo " $PRG <zpool_name> [total|free|pfree|used] ";
    echo "     total - to show value of total space ";
    echo "     free - to show value of free space left ";
    echo "     pfree - to show value of free space left in percentage";
    echo "     used - to show value of used space ";
    echo "";
    echo " REMARK: This script works only on Solaris OS or Linux with ZFS."
    exit 0;
}


if [ $# -ne 2 ]; then
    f_usage;
    exit 0;
fi

free=`zfs get -Hp available $1 | cut -f3`;
used=`zfs get -Hp used $1 | cut -f3`;

case "$2" in
    "free" )
    echo $free
    ;;

    "used" )
    echo $used
    ;;

    "total" )
    total=$(($free+$used));
    echo $total;
    ;;

    "pfree" )
    total=$(($free+$used));
    # Zabbix need scale 6 for percentage
    pfree=$(echo "scale=6; ($free*100)/$total" | bc );
    echo $pfree
    ;;

    * )
    echo "Not implemented yet";
    f_usage;
    ;;
esac

exit 0;
