PROGRAM BubbleSort(INPUT, OUTPUT);
{Сортируем первую строку INPUT в OUTPUT}
VAR
  Sorted, Ch, Ch1, Ch2: CHAR;
  F1, F2: TEXT;
PROCEDURE Copy(VAR InputF, OutputF: TEXT);
VAR
  Ch: CHAR;
BEGIN{Copy}
  WHILE NOT EOLN(InputF)
  DO
    BEGIN
      READ(InputF, Ch);
      WRITE(OutputF, Ch)
    END;
  WRITELN(OutputF)
END;{Copy}
BEGIN{BubbleSort}
  {Копируем INPUT в F2}
  REWRITE(F2);
  Copy(INPUT, F2);
  {Копируем F2 в F1}
  RESET(F2);
  REWRITE(F1);
  Copy(F2, F1);
  {Копируем F1 в OUTPUT}
  RESET(F1);
  Copy(F1, OUTPUT)
END.{BubbleSort}
