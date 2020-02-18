PROGRAM MinSort3(INPUT,OUTPUT);
VAR 
  Ch1, Ch2, Ch3: CHAR;
BEGIN
  READ(Ch1, Ch2, Ch3);
  WRITELN('¬ходные данные: ', Ch1, Ch2, Ch3);
  WRITE('—ортированные данные: ');
  IF Ch1 < Ch2
  THEN
    IF Ch1 < Ch3
    THEN
      BEGIN
        WRITE(Ch1);
        Ch1 := Ch3
      END
    ELSE
      WRITE(Ch3)
  ELSE
    IF Ch2 < Ch3
    THEN
      BEGIN
        WRITE(Ch2);
        Ch2 := Ch3
      END
    ELSE
      WRITE(Ch3);
  IF Ch1 < Ch2
    THEN
      WRITE(Ch1, Ch2)
    ELSE
      WRITE(Ch2, Ch1);
  WRITELN
END.
