SQLPLUS=sqlplus
SQLPLUS_ARGS="sys/$PASSWORD as sysdba"

timezone_upgrade(){
	cd /scripts
	echo
	echo "!!!!!!!!!!!!!!!!!!!!!!!!!"
	echo "Opening upgrade window..."
	echo
	$SQLPLUS -S $SQLPLUS_ARGS @timezone_prepare_upgrade < /dev/null 
	echo
	echo "!!!!!!!!!!!!!!!!!!!!!!"
	echo "Shuting down Oracle..."
	echo
	$SQLPLUS -S $SQLPLUS_ARGS @oracle_shutdown < /dev/null 
	echo
	echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!"
	echo "Starting in upgrade mode..."
	echo
	$SQLPLUS -S $SQLPLUS_ARGS @oracle_startupupgrademode < /dev/null 
	echo
	echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
	echo "Upgrading timezone to version 31..."
	echo
	$SQLPLUS -S $SQLPLUS_ARGS @timezone_start_upgrade < /dev/null 
	echo
	echo "!!!!!!!!!!!!!!!!!!!!!!"
	echo "Shuting down Oracle..."
	echo
	$SQLPLUS -S $SQLPLUS_ARGS @oracle_shutdown < /dev/null 
	echo
	echo "!!!!!!!!!!!!!!!!!!!!!!!!!!"
	echo "Starting in normal mode..."
	echo
	$SQLPLUS -S $SQLPLUS_ARGS @oracle_startup < /dev/null 
	echo
	echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
	echo "Running middle upgrade script..."
	echo
	$SQLPLUS -S $SQLPLUS_ARGS @timezone_middle_upgrade < /dev/null 
	echo
	echo "!!!!!!!!!!!!!!!!!!!!!!!!"
	echo "Ending upgrade window..."
	echo
	$SQLPLUS -S $SQLPLUS_ARGS @timezone_end_upgrade < /dev/null 
}

copy_files(){
	echo
	echo "!!!!!!!!!!!!!!!!!!!!!!!!!"
	echo "Copying timezone files..."
	echo
	cp -a /files/timezone_31.dat $ORACLE_HOME/oracore/zoneinfo
  cp -a /files/timezlrg_31.dat $ORACLE_HOME/oracore/zoneinfo
}

copy_files
timezone_upgrade