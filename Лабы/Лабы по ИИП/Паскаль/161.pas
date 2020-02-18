PROGRAM CountRevers(INPUT, OUTPUT);
USES
  Count3;
VAR
  X100, X10, X1, Oflow, C1, C2, C3: CHAR;    
BEGIN{CountRevers}
  WRITE('Входные данные: ');
  Start;
  Oflow := 'N';
  IF NOT EOLN(INPUT)
  THEN
    READ(C2);
  IF NOT EOLN(INPUT) 
  THEN 
    READ(C3);
  WHILE NOT EOLN(INPUT)
  DO
    BEGIN{Движение окна}
      C1 := C2; 
      C2 := C3;
      READ(C3);
      IF ((C1 > C2) AND (C2 < C3)) OR ((C1 < C2) AND (C2 > C3))
      THEN
        Bump
    END;{Движение окна}
  Value(X100, X10, X1);
  CheckOverflow(Oflow);
  IF Oflow <> 'Y'
  THEN
    WRITELN('Количество реверсов равно ', X100, X10, X1)
  ELSE
    WRITELN('Количество реверсов превышает 999')
END.{CountRevers}
