PROGRAM Delete(INPUT, OUTPUT);
VAR
  Q: CHAR;
BEGIN 
  IF NOT(EOLN)
  THEN
    BEGIN
      READ(Q);
      IF Q = ' '
      THEN
        WHILE (Q = ' ') AND (NOT(EOLN))
        DO
          READ(Q)      
    END;
  WRITE(Q);        
  WHILE NOT(EOLN)
  DO
    BEGIN
      READ(Q); 
      IF Q = ' '
      THEN
        BEGIN
          WHILE (Q = ' ') AND (NOT(EOLN))
          DO
            BEGIN
              READ(Q);
              IF Q <> ' '
              THEN 
                WRITE(' ')
            END
        END;
      IF Q <> ' '
      THEN
        WRITE(Ch)
    END;
  WRITELN  
END.
