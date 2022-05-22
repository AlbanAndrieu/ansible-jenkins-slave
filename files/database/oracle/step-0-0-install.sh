#!/bin/bash
#set -xv

source ./step-0-color.sh

#source $HOME/.bash_profile

echo -e "${yellow} ${bold}INSTALLING ORACLE INSTANT CLIENT ${NC}"

#HOME="/home/jenkins" on linux
#HOME="/Users/jenkins" on osx
DOWNLOAD_URL="https://albandrieu.com/download"

if [[ ! -d /opt/oracle/instantclient_12_2/help/ ]]; then
  echo "${green} Installing oracle/instantclient ${NC}"
  if [[ "$(uname -s)" == "SunOS" ]]; then
    mkdir -p /opt/oracle
    cd /opt/oracle
    #cd ${HOME}/Developer
    wget --no-check-certificate ${DOWNLOAD_URL}/oracle/instantclient-basic-solaris.x64-12.2.0.1.0.zip
    unzip instantclient-basic-solaris.x64-12.2.0.1.0.zip
    wget --no-check-certificate ${DOWNLOAD_URL}/oracle/instantclient-jdbc-solaris.x64-12.2.0.1.0.zip
    unzip instantclient-jdbc-solaris.x64-12.2.0.1.0.zip
    wget --no-check-certificate ${DOWNLOAD_URL}/oracle/instantclient-odbc-solaris.x64-12.2.0.1.0.zip
    unzip instantclient-odbc-solaris.x64-12.2.0.1.0.zip
    ln -s /opt/oracle/instantclient_12_2 /jenkins/Developer/instantclient_12_2
    #LD_LIBRARY_PATH=${HOME}/Developer/instantclient_12_2:$LD_LIBRARY_PATH
  elif [[ "$(uname -s)" == "Darwin" ]]; then
    mkdir -p /opt/oracle
    cd /opt/oracle
    #cd ${HOME}/Developer
    wget --no-check-certificate ${DOWNLOAD_URL}/oracle/instantclient-basic-macos.x64-12.1.0.2.0.zip
    unzip instantclient-basic-macos.x64-12.1.0.2.0.zip
    wget --no-check-certificate ${DOWNLOAD_URL}/oracle/instantclient-jdbc-macos.x64-12.1.0.2.0.zip
    unzip instantclient-jdbc-macos.x64-12.1.0.2.0.zip
    wget --no-check-certificate ${DOWNLOAD_URL}/oracle/instantclient-odbc-macos.x64-12.1.0.2.0.zip
    unzip instantclient-odbc-macos.x64-12.1.0.2.0.zip
    #ln -s /opt/oracle/instantclient_12_2 /Users/jenkins/Developer/instantclient_12_2
    #LD_LIBRARY_PATH=/Users/jenkins/Developer/instantclient_12_1:$LD_LIBRARY_PATH
  elif [[ "$(uname -s)" == "Linux" ]]; then
    mkdir -p /opt/oracle
    cd /opt/oracle
    #cd ${HOME}/Developer
    wget --no-check-certificate ${DOWNLOAD_URL}/oracle/instantclient-basic-linux.x64-12.2.0.1.0.zip
    unzip instantclient-basic-linux.x64-12.2.0.1.0.zip
    wget --no-check-certificate ${DOWNLOAD_URL}/oracle/instantclient-jdbc-linux.x64-12.2.0.1.0.zip
    unzip instantclient-jdbc-linux.x64-12.2.0.1.0.zip
    wget --no-check-certificate ${DOWNLOAD_URL}/oracle/instantclient-odbc-linux.x64-12.2.0.1.0.zip
    unzip instantclient-odbc-linux.x64-12.2.0.1.0.zip
    wget --no-check-certificate ${DOWNLOAD_URL}/oracle/instantclient-sqlplus-linux.x64-12.2.0.1.0.zip
    unzip instantclient-sqlplus-linux.x64-12.2.0.1.0.zip
    #ln -s /opt/oracle/instantclient_12_2 /jenkins/Developer/instantclient_12_2
    #mkdir -p /home/jenkins/Developer
    #ln -s /opt/oracle/instantclient_12_2 /home/jenkins/Developer/instantclient_12_2
    #LD_LIBRARY_PATH=${HOME}/Developer/instantclient_12_2:$LD_LIBRARY_PATH
  fi
fi

export LD_LIBRARY_PATH=/opt/oracle/instantclient_12_2:$LD_LIBRARY_PATH
export PATH=/opt/oracle/instantclient_12_2:$PATH

# Set the $TNS_ADMIN environment variable so that sqlplus knows where to look
export TNS_ADMIN=/opt/oracle/instantclient_12_2

#Run odbcinst -j to get the location of the odbcinst.ini and odbc.ini
odbcinst -j

#From Unix Client
echo "Check odbc connection"
echo "osql -S TEST_2016 -U 'sa' -P 'microsoft'"
echo "isql -v TEST_2016 'sa' 'microsoft'"
echo "/opt/oracle/instantclient_12_2/sqlplus sys/microsoft\$@//localhost:1521/ORCLPDB1 as sysdba"
#From Windows Client
echo "sqlcmd -S TEST -U so -P microsoft"

exit 0
