#!/bin/bash
#PASSWORD=${1:-secret}

SQLPLUS=sqlplus
SQLPLUS_ARGS="sys/$PASSWORD@XE as sysdba"

verify_connection(){
	echo "exit" | ${SQLPLUS} -L $SQLPLUS_ARGS | grep Connected > /dev/null
	if [ $? -eq 0 ];
	then
	   echo "Database Connetion is OK"
	else
	   echo -e "Database Connection Failed. Connection failed with:\n $SQLPLUS -S $SQLPLUS_ARGS\n `$SQLPLUS -S $SQLPLUS_ARGS` < /dev/null"
	   exit 1
	fi

	if [ "$(ls -A /u01/app/oracle)" ]; then
		echo "Check Database files folder: OK"
	else
		echo -e "Failed to find database files, run example:\n docker run -it --rm --volumes-from $oracle_db_name:oracle-database --link $oracle_db_name:oracle-database apex_ords install"
		exit 1
	fi
}

disable_http(){
	echo "Turning off DBMS_XDB HTTP port"
	echo "EXEC DBMS_XDB.SETHTTPPORT(0);" | $SQLPLUS -S $SQLPLUS_ARGS
}

enable_http(){
	echo "Turning on DBMS_XDB HTTP port"
	echo "EXEC DBMS_XDB.SETHTTPPORT(8888);" | $SQLPLUS -S $SQLPLUS_ARGS
}

get_oracle_home(){
	echo "Getting ORACLE_HOME Path"
	ORACLE_HOME=`echo -e "var ORACLEHOME varchar2(200);\n EXEC dbms_system.get_env('ORACLE_HOME', :ORACLEHOME);\n PRINT ORACLEHOME;" | $SQLPLUS -S $SQLPLUS_ARGS | grep "/.*/"`
	echo "ORACLE_HOME found: $ORACLE_HOME"
}

timezone_upgrade(){
	cd /u01/app/oracle/apex
	echo "Shuting down Oracle..."
	$SQLPLUS -S $SQLPLUS_ARGS shutdown immediate < /dev/null
	echo "Starting in upgrade mode..."
	$SQLPLUS -S $SQLPLUS_ARGS startup upgrade < /dev/null
	echo "Upgrading timezone to version 31..."
	$SQLPLUS -S $SQLPLUS_ARGS exec DBMS_DST.BEGIN_UPGRADE(31) < /dev/null
	echo "Shuting down Oracle..."
	$SQLPLUS -S $SQLPLUS_ARGS shutdown immediate < /dev/null
	echo "Starting in normal mode..."
	$SQLPLUS -S $SQLPLUS_ARGS startup < /dev/null
	cd /scripts
	echo "Running start upgrade script..."
	$SQLPLUS -S $SQLPLUS_ARGS @timezone_start_upgrade < /dev/null
	echo "Running end upgrade script..."
	$SQLPLUS -S $SQLPLUS_ARGS @timezone_end_upgrade < /dev/null
}

copy_files(){
	echo "Copy timezone files"
	cp -a timezone_31.dat /u01/app/oracle/product/11.2.0/xe/oracore/zoneinfo
  cp -a timezlrg_31.dat /u01/app/oracle/product/11.2.0/xe/oracore/zoneinfo
}

verify_connection
copy_files
disable_http
timezone_upgrade
enable_http

