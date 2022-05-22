#!/bin/ksh
#set -x

PRG=`basename $0`
export PATH=$PATH:/opt/zabbix/bin

host=`hostname`;

function f_usage {
    echo "Script status for iSCSI connections.";
    echo "";
    echo "Usage:";
    echo " $PRG <zabbix_server> [test]";
    echo "     zabbix_sever - Zabbix server ";
    echo "     test - to show values instead of sending them to Zabbix ";
    echo "";
    echo " REMARK: This script works only on Linux OS as trapper item."
    exit 0;
}

if [ $# -gt 2 ]; then
    f_usage;
    exit 0;
fi

monitor=$1;

if [ $# -eq 2 ]; then
    case "$2" in
        "test" )
        test=$1;
        ;;

        * )
        echo "Not implemented yet";
        f_usage;
        ;;
    esac
fi

platform='unknown'
unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
    platform='linux'
    iscsiMsg="$(iscsiadm -m session -P 3 | awk '$NF>1{print $0}')";
elif [[ "$unamestr" == 'SunOS' ]]; then
    platform='solaris'
    iscsiMsg="$(iscsiadm list target)";
fi

if [ $? -ne 0 ]; then
    echo -1;
    exit -1;
fi


let countLivingConn=0
let countConfiguredConn=0
if [[ "$unamestr" == 'Linux' ]]; then
    countLivingConn=$(echo "$iscsiMsg" | grep -i "iSCSI Session State: LOGGED_IN" |wc -l);
    countConfiguredConn=$(echo "$iscsiMsg" | grep -i "Current Portal" |wc -l);
elif [[ "$unamestr" == 'SunOS' ]]; then
    countLivingConn=$(echo "$iscsiMsg" | egrep -i "Connections: 1" |wc -l);
    countConfiguredConn=$(echo "$iscsiMsg" | egrep -i "Target" |wc -l);
fi

if [ $test ]; then
    print "connections: living: $countLivingConn, configured: $countConfiguredConn\n";
else
    #print "connections: living: $countLivingConn, configured: $countConfiguredConn\n";
    zabbix_sender -z $monitor -p 10051 -s $host -k iscsi_total -o $countConfiguredConn 1>/dev/null 2>&1;
    zabbix_sender -z $monitor -p 10051 -s $host -k iscsi_living -o $countLivingConn 1>/dev/null 2>&1;
fi
echo 1;
exit 0;
