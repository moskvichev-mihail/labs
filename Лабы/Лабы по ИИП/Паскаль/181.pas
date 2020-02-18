PROGRAM SortMonth(INPUT, OUTPUT);
USES
  Date1;
VAR
  M1, M2: Month;
BEGIN{SortMonth}
  ReadMonth(INPUT, M1);
  ReadMonth(INPUT, M2);
  IF (M1 = NoMonth) OR (M2 = NoMonth){—равнение дат и вывод в OUTPUT}
  THEN
    WRITELN('¬ходные данные записаны неверно')
  ELSE
    IF M1 = M2
    THEN
      BEGIN
        WRITE('ќба мес€ца ');
        WriteMonth(OUTPUT, M1)
      END
    ELSE
      BEGIN
        WriteMonth(OUTPUT, M1);
        IF M1 < M2
        THEN
          WRITE(' предшествует ')
        ELSE
          WRITE(' следует за ');
        WriteMonth(OUTPUT, M2) 
      END;
  WRITELN
END.{SortMonth}     
