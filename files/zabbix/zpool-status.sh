#!/bin/bash
#set -x

PRG=`basename $0`

function f_usage {
    echo "Script shows status of zpool";
    echo "";
    echo "Usage:";
    echo " $PRG <zpool_name> ";
    echo "";
    echo " REMARK: This script works only on Solaris OS or Linux with ZFS."
    exit 0;
}


if [ $# -ne 1 ]; then
    f_usage;
    exit 0;
fi

status=$(zpool list $1);
i=0;
j=0;
first=0;

for line in "$status"
do
	for word in $line
	do
		if [[ first -eq 0 ]]; then
			if [[ "$word" == 'HEALTH' ]] ; then
				let i=$i+1;
				let first=1;
				continue 1;
			else
				let i=$i+1;
			fi
		else
			if [[ $i -ne $j ]] ; then
				let j=j+1;
			else
				echo "$word";
				let j=0;
				continue 1;
			fi
		fi
	done;
done;

exit 0;
