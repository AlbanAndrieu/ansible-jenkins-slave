#!/bin/ksh
#set -x

PRG=`basename $0`
export PATH=$PATH:/usr/sbin:/opt/HPQacucli/sbin

function f_usage {
    echo "Script shows number of status errors for all arrays";
    echo "";
    echo "Usage:";
    echo " $PRG ";
    echo "";
    echo " REMARK: This script works only on Solaris and Linux OS with HPQacucli Tools."
    exit 0;
}


if [ $# -ne 0 ]; then
    f_usage;
    exit 0;
fi

# counting errors on all arrays
status="OK";
ctrlMsg="";
warnMsg='';

if ! [ -x "$(command -v hpacucli)" ]; then
   echo "STATUS:OK";
   echo "hpacucli is not installed";
   exit 0;
fi

arrayMsg="$(hpacucli controller all show config | awk '$NF>1{print $0}')";
if [ $? -ne 0 ]; then
   status="ERRORS";
fi

if [ "$arrayMsg" == 'Error: No controllers detected.' ]; then
   echo "STATUS:OK";
   echo "$arrayMsg";
   exit 0;
fi

if [ "$arrayMsg" == 'Another instance of hpacucli is running! Stop it first.' ]; then
   status='WARNING';
   warnMsg="$arrayMsg";
fi

countErrors=$(echo "$arrayMsg" | egrep -e "logicaldrive|physicaldrive" | egrep -v OK |wc -l);
if [ $countErrors -ne 0 ]; then
   status="ERRORS";
fi

# read data from controllers
echo "$arrayMsg" | grep -i Slot | cut -f6 -d" " | while read fstype
do
    ctrlTmpMsg="$(hpacucli controller slot=$fstype show)";
    if [ $? -ne 0 ]; then
        if [ "$ctrlTmpMsg" == 'Another instance of hpacucli is running! Stop it first.' ]; then
            if [ "$status" == 'OK' ]; then
                status='WARNING';
            fi
        else
            status="ERRORS";
        fi
    fi

    ctrlMsg="$ctrlTmpMsg \n $ctrlMsg";
done

countErrors=$(echo "$ctrlMsg" | grep -i failed | wc -l);
if [ $countErrors -ne 0 ]; then
    status="ERRORS";
fi

echo "STATUS:$status";
if [ "$status" != "OK" ]; then
   echo "$warnMsg";
   echo "$ctrlMsg";
   echo "$arrayMsg";
fi

exit 0;
