PROGRAM Split(INPUT, OUTPUT);
VAR
  Ch: CHAR;
  Odds, Evens: TEXT;
BEGIN
  REWRITE(Odds);
  REWRITE(Evens);
  READ(INPUT, Ch);
  WHILE Ch <> '#'
  DO
    BEGIN
      IF (Ch = '1') OR (Ch = '3') OR (Ch = '5') OR (Ch = '7') OR (Ch = '9')
      THEN
        BEGIN
          WRITE(Odds, Ch);
          WRITE(OUTPUT, Ch);
          READ(INPUT, Ch)
        END
      ELSE
        IF (Ch = '0') OR (Ch = '2') OR (Ch = '4') OR (Ch = '6') OR (Ch = '8')
        THEN
          BEGIN
            WRITE(Evens, Ch);
            WRITE(OUTPUT, Ch);
            READ(INPUT, Ch)
          END;
    END;
  WRITELN(Odds, '#');
  WRITELN(Evens, '#')
END.
