PROGRAM Split(INPUT, OUTPUT);
  {Копирует INPUT в OUTPUT,сначала нечетные,а затем четные
   элементы}
VAR
  Ch: CHAR;
  Odds, Evens: TEXT;
PROCEDURE CopyOut(VAR F1: TEXT; VAR Ch: CHAR);
BEGIN
  RESET(F1);
  WHILE NOT EOF(F1)
  DO
    BEGIN
      WHILE NOT EOLN(F1)
      DO
        BEGIN
          READ(F1, Ch);
          WRITE(OUTPUT, Ch)
        END;
      READLN(F1)
    END
END;
PROCEDURE Split(VAR Odds, Evens: TEXT);
VAR
  Ch, Next: CHAR;
BEGIN
  REWRITE(Odds);
  REWRITE(Evens);
  Next := 'O';
  WHILE NOT EOF(INPUT)
  DO
    BEGIN
      WHILE NOT EOLN(INPUT)
      DO {Прочитать Ch, записать в файл, выбранный через Next,переключить Next}
        BEGIN
          READ(INPUT, Ch);
          IF Next = 'O'
          THEN
            BEGIN
              WRITE(Odds, Ch);
              Next := 'E'
            END
          ELSE
            IF Next = 'E'
            THEN
              BEGIN
                WRITE(Evens, Ch);
                Next := 'O'
              END
        END;
      READLN(INPUT);
      WRITELN(Odds);
      WRITELN(Evens)
    END
END;
BEGIN
  Split(Odds, Evens);
  CopyOut(Odds, Ch);
  CopyOut(Evens, Ch);
  WRITELN(OUTPUT)
END.
