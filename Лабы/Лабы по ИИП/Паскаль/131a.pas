PROGRAM BubbleSort(INPUT, OUTPUT);
{��������� ������ ������ INPUT � OUTPUT}
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
  {�������� INPUT � F2}
  REWRITE(F2);
  Copy(INPUT, F2);
  {�������� F2 � F1}
  RESET(F2);
  REWRITE(F1);
  Copy(F2, F1);
  {�������� F1 � OUTPUT}
  RESET(F1);
  Copy(F1, OUTPUT)
END.{BubbleSort}
