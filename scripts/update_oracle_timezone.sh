#!/bin/bash
#PASSWORD=${1:-secret}

SQLPLUS=sqlplus
SQLPLUS_ARGS="sys/$PASSWORD@XE as sysdba"
SAVED_SID=$ORACLE_SID

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

get_oracle_home(){
	echo "Getting ORACLE_HOME Path"
	ORACLE_HOME=`echo -e "var ORACLEHOME varchar2(200);\n EXEC dbms_system.get_env('ORACLE_HOME', :ORACLEHOME);\n PRINT ORACLEHOME;" | $SQLPLUS -S $SQLPLUS_ARGS | grep "/.*/"`
	echo "ORACLE_HOME found: $ORACLE_HOME"
}

timezone_upgrade(){
	cd /scripts
	echo "Shuting down Oracle..."
	$SQLPLUS -S $SQLPLUS_ARGS @oracle_shutdown < /dev/null
#	echo "Starting in upgrade mode..."
#	$SQLPLUS -S $SQLPLUS_ARGS @oracle_startupupgrademode < /dev/null
#	echo "Upgrading timezone to version 31..."
#	$SQLPLUS -S $SQLPLUS_ARGS @timezone_start_upgrade < /dev/null
#	echo "Shuting down Oracle..."
#	$SQLPLUS -S $SQLPLUS_ARGS @oracle_shutdown < /dev/null
#	echo "Starting in normal mode..."
#	$SQLPLUS -S $SQLPLUS_ARGS @oracle_startup < /dev/null
#	cd /scripts
#	echo "Running middle upgrade script..."
#	$SQLPLUS -S $SQLPLUS_ARGS @timezone_middle_upgrade < /dev/null
#	echo "Running end upgrade script..."
#	$SQLPLUS -S $SQLPLUS_ARGS @timezone_end_upgrade < /dev/null

	echo "Starting in upgrade mode..."
  ORACLE_SID=$SAVED_SID
	$SQLPLUS -S $SQLPLUS_ARGS @oracle_startupupgrademode < /dev/null
	echo "Upgrading timezone to version 31..."
	$SQLPLUS -S $SQLPLUS_ARGS @timezone_start_upgrade < /dev/null
	echo "Shuting down Oracle..."
	$SQLPLUS -S $SQLPLUS_ARGS @oracle_shutdown < /dev/null
	echo "Starting in normal mode..."
  ORACLE_SID=$SAVED_SID
	$SQLPLUS -S $SQLPLUS_ARGS @oracle_startup < /dev/null
	cd /scripts
	echo "Running middle upgrade script..."
	$SQLPLUS -S $SQLPLUS_ARGS @timezone_middle_upgrade < /dev/null
	echo "Running end upgrade script..."
	$SQLPLUS -S $SQLPLUS_ARGS @timezone_end_upgrade < /dev/null

}

copy_files(){
	echo "Copy timezone files"
	cp -a /files/timezone_31.dat /u01/app/oracle/product/11.2.0/xe/oracore/zoneinfo
  cp -a /files/timezlrg_31.dat /u01/app/oracle/product/11.2.0/xe/oracore/zoneinfo
}

verify_connection
copy_files
timezone_upgrade
