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

oracle_final_setup(){
	cd /scripts
	echo "Finishing Oracle setup..."
	$SQLPLUS -S $SQLPLUS_ARGS @oracle_final_setup < /dev/null
}

verify_connection
disable_http
oracle_final_setup
enable_http