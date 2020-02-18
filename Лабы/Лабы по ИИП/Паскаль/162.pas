PROGRAM TestRemove(INPUT, OUTPUT);
{„итает строку из входа ,пропускает ее через RemoveExtraBlanks}
USES 
  Queue;
VAR
  Ch: CHAR;
  
PROCEDURE RemoveExtraBlanks;
{”дал€ет лишниe пробелы между словами на одной строке}
VAR
  Ch, Blank, LineEnd: CHAR;
BEGIN {RemoveExtraBlanks}
  Blank := ' ';
  LineEnd := '$';
  AddQ(LineEnd); {помечаем конец текста в очереди}
  HeadQ(Ch);
  WHILE Ch = Blank {удал€ем пробелы}
  DO
    BEGIN
      DelQ;
      HeadQ(Ch)
    END;{удал€ем пробелы}
  WHILE Ch <> LineEnd{читаем слово}
  DO
    BEGIN
      WHILE (Ch <> Blank) AND (Ch <> LineEnd)
      DO
        BEGIN
          AddQ(Ch);
          DelQ;
          HeadQ(Ch)
        END;{читаем слово}
      WHILE Ch = Blank {удал€ем пробелы}
      DO
        BEGIN
          DelQ;
          HeadQ(Ch)
        END;{удал€ем пробелы}
      IF Ch <> LineEnd{¬ставл€ем пробел между словами}
      THEN
        AddQ(Blank){¬ставл€ем пробел между словами}
    END;
  DelQ {уда€ем LineEnd из очереди}
END; {RemoveExtraBlanks}

BEGIN {TestRemove}
  CleanQ;
  WRITE('¬ход :');
  WHILE NOT EOLN(INPUT)
  DO
    BEGIN
      READ(Ch);
      WRITE(Ch);
      AddQ(Ch);
    END;
  WRITELN(OUTPUT);
  RemoveExtraBlanks;
  WRITE('¬ыход :');
  HeadQ(Ch);
  WHILE Ch <> '#'
  DO
    BEGIN
      WRITE(Ch);
      DelQ;
      HeadQ(Ch)
    END;
  WRITELN(OUTPUT)
END. {TestRemove}
