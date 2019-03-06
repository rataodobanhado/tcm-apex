VAR numfail number
BEGIN
  EXECUTE IMMEDIATE ('ALTER SESSION SET "_WITH_SUBQUERY"=MATERIALIZE');
  EXECUTE IMMEDIATE ('ALTER SESSION SET "_SIMPLE_VIEW_MERGING"=TRUE');

	DBMS_DST.UPGRADE_DATABASE(:numfail,
			parallel => TRUE,
			log_errors => TRUE,
			log_errors_table => 'SYS.DST$ERROR_TABLE',
			log_triggers_table => 'SYS.DST$TRIGGER_TABLE',
			error_on_overlap_time => FALSE,
			error_on_nonexisting_time => FALSE);
--	DBMS_OUTPUT.PUT_LINE('Failures:'|| :numfail);
END;
/