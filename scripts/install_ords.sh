#!/bin/bash
#PASSWORD=${1:-secret}

cat /files/ords-18.4.0.354.1002.zipa* > /files/ords-18.4.0.354.1002.zip
unzip -o /files/ords-18.4.0.354.1002.zip -d /u01/ords

sed -i -E 's:secret:'$PASSWORD':g' /scripts/ords_params.properties
cp -rf /scripts/ords_params.properties /u01/ords/params
cd /u01/ords
java -jar ords.war configdir /u01
java -jar ords.war install simple

# solution for the problem with timezone
#dpkg-reconfigure tzdata
echo "Europe/Warsaw" > /etc/timezone
dpkg-reconfigure -f noninteractive tzdata

cp -rf /u01/ords/ords.war /tomcat/webapps/
cp -rf /u01/app/oracle/apex/images /tomcat/webapps/i

sed -i -E 's:secret:'$PASSWORD':g' /scripts/ords_unlock_account.sql
sqlplus -S sys/$PASSWORD@XE as sysdba @/scripts/ords_unlock_account.sql < /dev/null