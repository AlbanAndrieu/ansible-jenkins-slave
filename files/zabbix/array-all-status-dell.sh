#!/bin/ksh
#set -x

PRG=`basename $0`
export PATH=$PATH:/usr/sbin:/opt/MegaRAID/perccli

function f_usage {
    echo "Script shows number of status errors for all arrays";
    echo "";
    echo "Usage:";
    echo " $PRG ";
    echo "";
    echo " REMARK: This script works only on Linux OS with perccli tool."
    exit 0;
}

if [ $# -ne 0 ]; then
    f_usage;
    exit 0;
fi

# counting errors on all arrays
status="OK";
warnMsg='';

if ! [ -x "$(command -v perccli64)" ]; then
   echo "STATUS:OK";
   echo "perccli64 is not installed";
   exit 0;
fi

arrayMsg="$(perccli64 /call show | awk '$NF>1{print $0}')";
if [ $? -ne 0 ]; then
   status="ERRORS";
fi

##on system without Dell ctrl
countErrors=$(echo $arrayMsg | grep -i 'No Controller found' | wc -l);
if [ $countErrors -ne 0 ]; then
   echo "STATUS:OK";
   echo "$arrayMsg";
   exit 0;
fi

# Check controllers
countErrors=$(perccli64 /call show health all | grep -i "Overall Health" | grep -v GOOD |wc -l);
if [ $countErrors -ne 0 ]; then
   status="ERRORS";
fi

# check disks
countErrors=$(perccli64 /call/eall/sall show | grep -i '^[0-9][0-9]:[0-9]' | grep -vE 'Onln|JBOD' | wc -l);
if [ $countErrors -ne 0 ]; then
   status="ERRORS";
fi

# check battery
countErrors=$(perccli64 /call/bbu show | grep -i "BBU " | grep -v Optimal | wc -l);
if [ $countErrors -ne 0 ]; then
   status="ERRORS";
fi

echo "STATUS:$status";
if [ "$status" != "OK" ]; then
   echo "$warnMsg";
   echo "$arrayMsg";
fi

exit 0;
