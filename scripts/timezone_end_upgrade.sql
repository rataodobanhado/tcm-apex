VAR fail number
BEGIN
  DBMS_DST.END_UPGRADE(:fail);
  --DBMS_OUTPUT.PUT_LINE('Failures:'|| :fail);
END;
/